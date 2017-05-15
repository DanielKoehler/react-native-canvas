#import "DKCanvasView.h"

#import "EJTimer.h"
#import "EJBindingBase.h"
#import "EJCanvasContext2DScreen.h"

#import "EJClassLoader.h"
#import "EJConvertTypedArray.h"
#import <objc/runtime.h>



#pragma mark -
#pragma mark Ejecta view Implementation

@implementation DKCanvasView

@synthesize appFolder;

@synthesize pauseOnEnterBackground;
@synthesize isPaused;
@synthesize hasScreenCanvas;
//@synthesize jsGlobalContext;
@synthesize exitOnMenuPress;
@synthesize startTime;

@synthesize currentRenderingContext;
@synthesize openGLContext;

@synthesize windowEventsDelegate;
@synthesize touchDelegate;
@synthesize deviceMotionDelegate;
@synthesize screenRenderingContext;

@synthesize backgroundQueue;
@synthesize classLoader;


- (id)initWithFrame:(CGRect)frame {
	if( self = [super initWithFrame:frame] ) {
        [self setup];
	}
	return self;
}

-(void)awakeFromNib {
    [self setup];
}




-(void)setup {
    
    oldSize = self.frame.size;
//    appFolder = folder;
    
    isPaused = false;
	exitOnMenuPress = true;
    
    // CADisplayLink (and NSNotificationCenter?) retains it's target, but this
    // is causing a retain loop - we can't completely release the scriptView
    // from the outside.
    // So we're using a "weak proxy" that doesn't retain the scriptView; we can
    // then just invalidate the CADisplayLink in our dealloc and be done with it.
    proxy = [EJNonRetainingProxy proxyWithTarget:self];
    
    self.pauseOnEnterBackground = YES;
    
    // Limit all background operations (image & sound loading) to one thread
    backgroundQueue = [NSOperationQueue new];
    backgroundQueue.maxConcurrentOperationCount = 1;
    
    timers = [[EJTimerCollection alloc] initWithScriptView:self];
    startTime = NSDate.timeIntervalSinceReferenceDate;
    
    displayLink = [CADisplayLink displayLinkWithTarget:proxy selector:@selector(run:)];
    [displayLink setFrameInterval:1];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    // Retain the caches here, so even if they're currently unused in JavaScript,
    // they will persist until the last scriptView is released
    textureCache = [EJSharedTextureCache instance];
  
    // openALManager = [EJSharedOpenALManager instance];
    openGLContext = [EJSharedOpenGLContext instance];
    
    // Create the OpenGL context for Canvas2D
    glCurrentContext = openGLContext.glContext2D;
    [EAGLContext setCurrentContext:glCurrentContext];
  
}

-(void) setContextType: (NSString*) type {
    
//    if( contextMode != kEJCanvasContextModeInvalid ) {
//        // Nothing changed? - just return the already created context
//        if( contextMode == newContextMode ) {
//            return jsCanvasContext;
//        }
//    
//        // New mode is different from current? - we can't do that
//        else {
//            NSLog(@"Warning: CanvasContext already created. Can	't change 2d/webgl mode.");
//            return NULL;
//        }
//    }
    
//    contextMode = newContextMode;
    self.currentRenderingContext = nil;
    
    CGSize size = self.frame.size;
  
//    NSLog(@"setContextType: %@", self.frame);
  
    // Configure and create the Canvas Context
    EJCanvasContext* renderingContext = [[EJCanvasContext2DScreen alloc] initWithScriptView:self width:size.width height:size.height];
    
    // TODO
    
    // Parse the options object, if present.
    // E.g.: {antialias: true, antialiasSamples: 4, preserveDrawingBuffer: true}
//    if( argc > 1 ) {
//        NSObject *optionsObj = JSValueToNSObject(ctx, argv[1]);
//        if( [optionsObj isKindOfClass:NSDictionary.class] ) {
//    
//            NSDictionary *options = (NSDictionary *)optionsObj;
//    
//            // Only override the default for preserveDrawingBuffer if this options is not undefined.
//            // For Canvas2D this defaults to true, for WebGL it defaults to false.
//            if( options[@"preserveDrawingBuffer"] ) {
//                renderingContext.preserveDrawingBuffer = [options[@"preserveDrawingBuffer"] boolValue];
//            }
//    
//            // If antialias is enabled, figure out the max samples this hardware supports and
//            // clamp the antialiasSamples to it, if present. Otherwise default to 2 samples.
//            if( [options[@"antialias"] boolValue] ) {
//                int msaaSamples = (int)[options[@"antialiasSamples"] integerValue];
//                int maxSamples = 2;
//                glGetIntegerv(GL_MAX_SAMPLES_APPLE, &maxSamples);
//    
//                renderingContext.msaaEnabled = maxSamples > 1;
//                renderingContext.msaaSamples = MAX(2, MIN(maxSamples, msaaSamples));
//            }
//        }
//    }
    
    
    
    self.screenRenderingContext = (EJCanvasContext<EJPresentable> *)renderingContext;
//    self.screenRenderingContext.style = style;

    
    [EAGLContext setCurrentContext:renderingContext.glContext];
    [renderingContext create];
    self.currentRenderingContext = renderingContext;
    
    // Execute the imageRendering setter again, now that we have a full created
    // rendering context
//    self.imageRendering = imageRendering;
}


- (void)dealloc {
    
	// Wait until all background operations are finished. If we would just release the
	// backgroundQueue it would cancel running operations (such as texture loading) and
	// could keep some dependencies dangling
	[backgroundQueue waitUntilAllOperationsAreFinished];

  // Remove from notification center
	self.pauseOnEnterBackground = false;

}

- (void)setPauseOnEnterBackground:(BOOL)pauses {
    
	NSArray *pauseN = @[
		UIApplicationWillResignActiveNotification,
		UIApplicationDidEnterBackgroundNotification,
		UIApplicationWillTerminateNotification
	];
	NSArray *resumeN = @[
		UIApplicationWillEnterForegroundNotification,
		UIApplicationDidBecomeActiveNotification
	];
	
	if (pauses) {
		[self observeKeyPaths:pauseN selector:@selector(pause)];
		[self observeKeyPaths:resumeN selector:@selector(resume)];
	} 
	else {
		[self removeObserverForKeyPaths:pauseN];
		[self removeObserverForKeyPaths:resumeN];
	}
	pauseOnEnterBackground = pauses;
    
}

- (void)removeObserverForKeyPaths:(NSArray*)keyPaths {
    
	NSNotificationCenter *nc = NSNotificationCenter.defaultCenter;
	for( NSString *name in keyPaths ) {
		[nc removeObserver:proxy name:name object:nil];
	}
    
}

- (void)observeKeyPaths:(NSArray*)keyPaths selector:(SEL)selector {
	
    NSNotificationCenter *nc = NSNotificationCenter.defaultCenter;
	for( NSString *name in keyPaths ) {
		[nc addObserver:proxy selector:selector name:name object:nil];
	}
    
}

- (void)layoutSubviews {
	[super layoutSubviews];  
  

  
	// Check if we did resize
	CGSize newSize = self.bounds.size;
	if( newSize.width != oldSize.width || newSize.height != oldSize.height ) {
		[windowEventsDelegate resize];
		oldSize = newSize;
	}
}


#pragma mark -
#pragma mark Script loading and execution
#pragma mark -
#pragma mark Run loop

- (void)run:(CADisplayLink *)sender {
//  NSLog(@"...");
	if(isPaused) { return; }
	
	// Check for lost gl context before invoking any JS calls
	if( glCurrentContext && EAGLContext.currentContext != glCurrentContext ) {
		EAGLContext.currentContext = glCurrentContext;
	}
	
	// We rather poll for device motion updates at the beginning of each frame instead of
	// spamming out updates that will never be seen.
	[deviceMotionDelegate triggerDeviceMotionEvents];
	
	// Check all timers
	[timers update];
	
	// Redraw the canvas
	self.currentRenderingContext = screenRenderingContext;
	[screenRenderingContext present];
}


- (void)pause {
	if( isPaused ) { return; }
	
	[windowEventsDelegate pause];
	[displayLink removeFromRunLoop:NSRunLoop.currentRunLoop forMode:NSDefaultRunLoopMode];
	[screenRenderingContext finish];
	isPaused = true;
}

- (void)resume {
	if( !isPaused ) { return; }
	
	[windowEventsDelegate resume];
	[EAGLContext setCurrentContext:glCurrentContext];
	[displayLink addToRunLoop:NSRunLoop.currentRunLoop forMode:NSDefaultRunLoopMode];
	isPaused = false;
}

//- (void)clearCaches {
//	JSGarbageCollect(jsGlobalContext);
//	
//	// Release all texture storages that haven't been bound in
//	// the last 5 seconds
//	[textureCache releaseStoragesOlderThan:5];
//}
//
- (void)setCurrentRenderingContext:(EJCanvasContext *)renderingContext {
	if( renderingContext != currentRenderingContext ) {
		[currentRenderingContext flushBuffers];
//		[currentRenderingContext release];
		
		// Switch GL Context if different
		if( renderingContext && renderingContext.glContext != glCurrentContext ) {
			glFlush();
			glCurrentContext = renderingContext.glContext;
			[EAGLContext setCurrentContext:glCurrentContext];
		}
		
		[renderingContext prepare];
//		currentRenderingContext = [renderingContext retain];
	}
}


#pragma mark -
#pragma mark Touch handlers

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[touchDelegate triggerEvent:@"touchstart" all:event.allTouches changed:touches remaining:event.allTouches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSMutableSet *remaining = [event.allTouches mutableCopy];
	[remaining minusSet:touches];
	
	[touchDelegate triggerEvent:@"touchend" all:event.allTouches changed:touches remaining:remaining];
//	[remaining release];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[touchDelegate triggerEvent:@"touchmove" all:event.allTouches changed:touches remaining:event.allTouches];
}

-(void)pressesBegan:(NSSet*)presses withEvent:(UIPressesEvent *)event {
	if( exitOnMenuPress && ((UIPress *)presses.anyObject).type == UIPressTypeMenu ) {
		return [super pressesBegan:presses withEvent:event];
	}
}

-(void)pressesEnded:(NSSet*)presses withEvent:(UIPressesEvent *)event {
	if( exitOnMenuPress && ((UIPress *)presses.anyObject).type == UIPressTypeMenu ) {
		return [super pressesEnded:presses withEvent:event];
	}
}

//TODO: Does this belong in this class?
#pragma mark
#pragma mark Timers


@end

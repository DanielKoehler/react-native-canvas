//
//  RCTCanvasManager.m
//  RNCanvas
//
//  Created by Daniel Koehler on 24/03/2016.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RCTViewManager.h"

#import "RCTWebViewManager.h"
#import "EJConvertColorRGBA.h"
//#import "EJCanvasContext2DScreen.h"

#import "RTCCanvasContext2D.h"

#import "RCTBridge.h"
#import "RCTUIManager.h"
#import "RCTWebView.h"
#import "UIView+React.h"


@interface RCTCanvasManager : RCTViewManager

@end

@implementation RCTCanvasManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  RTCCanvasContext2D* view = [[RTCCanvasContext2D alloc] initWithFrame:CGRectMake(0,0,320,300)];
  //  view.renderingContext
  return view;
}


- (void) addRCTUIBlockForTag: (nonnull NSNumber *) reactTag block: (void (^) (EJCanvasContext2DScreen* context)) handler {
  // Do something async / call URL
  [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
    
    RTCCanvasContext2D *view = (RTCCanvasContext2D*) viewRegistry[reactTag];
    if (![view isKindOfClass:[RTCCanvasContext2D class]]) {
      NSLog(@"Invalid view returned from registry, expecting RTCCanvasContext2d, got: %@", view);
    }
    DKCanvasView *canvas = view.canvas;
    EJCanvasContext2DScreen *context = (EJCanvasContext2DScreen *) canvas.screenRenderingContext;
    
    handler(context);
    
  }];
}


RCT_EXPORT_METHOD(scale:(nonnull NSNumber *) reactTag x:(float) x y:(float) y) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    [context scaleX:x y:y];
    
  }];
  
}


RCT_EXPORT_METHOD(translate:(nonnull NSNumber *) reactTag x:(float) x y:(float) y) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    [context translateX:x y:y];
    
  }];
  
}


RCT_EXPORT_METHOD(rotate:(nonnull NSNumber *) reactTag angle:(float) angle) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    [context rotate:angle];
    
  }];
  
}

RCT_EXPORT_METHOD(stroke:(nonnull NSNumber *) reactTag) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    [context stroke];
    
  }];
  
}


RCT_EXPORT_METHOD(fill:(nonnull NSNumber *) reactTag fillRule:(NSString *) rule) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    EJPathFillRule fillRule = ([rule isEqualToString:@"evenodd"])
    ? kEJPathFillRuleEvenOdd
    : kEJPathFillRuleNonZero;
    
    NSLog(@"fill");
    
    [context fill:fillRule];
    
  }];
}


RCT_EXPORT_METHOD(moveTo:(nonnull NSNumber *) reactTag x:(float)x y:(float) y) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    [context moveToX:x y:y];
    
  }];
}

//- (void) moveTo:(float)x y:(float) y {
//
//  [_renderingContext moveToX:x y:y];
//
//}



RCT_EXPORT_METHOD(lineTo:(nonnull NSNumber *) reactTag x:(float) x y:(float) y) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    [context lineToX:x y:y];
    
  }];
}

//- (void) lineTo: (float) x y:(float) y {
//
//  [_renderingContext lineToX:x y:y];
//
//}


RCT_EXPORT_METHOD(rect:(nonnull NSNumber *) reactTag x:(float) x y:(float) y w:(float) w h:(float) h) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    [context rectX:x y:y w:w h:h];
    
  }];
}


RCT_EXPORT_METHOD(fillRect:(nonnull NSNumber *) reactTag x:(float) x y:(float) y w:(float) w h:(float) h) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    [context fillRectX:x y:y w:w h:h];
    
  }];
}

RCT_EXPORT_METHOD(strokeRect:(nonnull NSNumber *) reactTag x:(float) x y:(float) y w:(float) w h:(float) h) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    [context strokeRectX:x y:y w:w h:h];
    
  }];
}

RCT_EXPORT_METHOD(clearRect:(nonnull NSNumber *) reactTag x:(float) x y:(float) y w:(float) w h:(float) h) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    [context clearRectX:x y:y w:w h:h];
    
  }];
}

RCT_EXPORT_METHOD(bezierCurveTo:(nonnull NSNumber *) reactTag cpx1:(float) cpx1 cpy1:(float) cpy1 cpx2:(float) cpx2 cpy2:(float) cpy2 x:(float) x y:(float) y) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    [context bezierCurveToCpx1:cpx1 cpy1:cpy1 cpx2:cpx2 cpy2:cpy2 x:x y:y];
    
  }];
}

//- (void) bezierCurveTo: (float) cpx1 cpy1:(float) cpy1 cpx2:(float) cpx2 cpy2:(float) cpy2 x:(float) x y:(float) y {
//
//  [_renderingContext bezierCurveToCpx1:cpx1 cpy1:cpy1 cpx2:cpx2 cpy2:cpy2 x:x y:y];
//
//}


RCT_EXPORT_METHOD(quadraticCurveTo:(nonnull NSNumber *) reactTag
                  cpx:(float) cpx
                  cpy:(float) cpy
                  x:(float) x
                  y:(float) y) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    [context quadraticCurveToCpx:cpx cpy:cpy x:x y:y];
    
  }];
}

//- (void) quadraticCurveTo: (float) cpx cpy:(float) cpy x:(float)x y:(float) y {
//
//  [_renderingContext quadraticCurveToCpx:cpx cpy:cpy x:x y:y];
//
//}

RCT_EXPORT_METHOD(arcTo:(nonnull NSNumber *) reactTag
                  x1:(float) x1
                  y1:(float) y1
                  x2:(float) x2
                  y2:(float) y2
                  radius:(float) radius) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    [context arcToX1:x1 y1:y1 x2:x2 y2:y2 radius:radius];
    
  }];
}

//- (void) arcTo:(float) x1
//            y1:(float) y1
//            x2:(float) x2
//            y2:(float) y2
//        radius:(float) radius {
//
//  [_renderingContext arcToX1:x1 y1:y1 x2:x2 y2:y2 radius:radius];
//
//}

RCT_EXPORT_METHOD(arc:(nonnull NSNumber *) reactTag
                  x:(float)x
                  y:(float)y
                  radius:(float)radius
                  startAngle:(float)startAngle
                  endAngle:(float)endAngle
                  antiClockwise:(BOOL)antiClockwise) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    [context arcX:x y:y radius:radius startAngle:startAngle endAngle:endAngle antiClockwise:antiClockwise];
    
  }];
}


RCT_EXPORT_METHOD(save:(nonnull NSNumber *) reactTag) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    [context save];
    
  }];
}


RCT_EXPORT_METHOD(restore:(nonnull NSNumber *) reactTag) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    [context restore];
    
  }];
}


////EJ_BIND_FUNCTION(save, ctx, argc, argv) {
////	[renderingContext save];
////	return NULL;
////}


//- (void) arc: (float)x
//           y:(float)y
//      radius:(float)radius
//  startAngle:(float)startAngle
//    endAngle:(float)endAngle
//antiClockwise:(BOOL)antiClockwise {
//
//  [_renderingContext arcX:x y:y radius:radius startAngle:startAngle endAngle:endAngle antiClockwise:antiClockwise];
//}

RCT_EXPORT_METHOD(measureText: (nonnull NSNumber *) reactTag string:(NSString *) string) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    
    EJTextMetrics metrics = [context measureText:string];
    //
    //  return @{@"width": @(metrics.width),
    //           @"actualBoundingBoxAscent": @(metrics.ascent),
    //           @"actualBoundingBoxDescent": @(metrics.descent)};
  }];
  
  // TODO::Do these values change? Should we not be passing back a static view of `metrics`
  //	return [EJBindingTextMetrics createJSObjectWithContext:ctx scriptView:_scriptView metrics:metrics];
}


//RCT_REMAP_METHOD(measureText:

                 
RCT_REMAP_METHOD(measureText, reactTag: (nonnull NSNumber *) reactTag string:(NSString *) string resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
  
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    
    EJTextMetrics metrics = [context measureText:string];
    
    resolve( @{@"width": @(metrics.width),
               @"actualBoundingBoxAscent": @(metrics.ascent),
               @"actualBoundingBoxDescent": @(metrics.descent)});
    
  }];

  
}


//RCT_EXPORT_METHOD(measureText: (nonnull NSNumber *) reactTag string:(NSString *) string) {
//
//  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
//
//
//    EJTextMetrics metrics = [context measureText:string];
//    //
//    //  return @{@"width": @(metrics.width),
//    //           @"actualBoundingBoxAscent": @(metrics.ascent),
//    //           @"actualBoundingBoxDescent": @(metrics.descent)};
//  }];
//
//  // TODO::Do these values change? Should we not be passing back a static view of `metrics`
//  //	return [EJBindingTextMetrics createJSObjectWithContext:ctx scriptView:_scriptView metrics:metrics];
//}


RCT_EXPORT_METHOD(fillText: (nonnull NSNumber *) reactTag string:(NSString *) string x:(float)x y:(float) y) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    // context = view.renderingContext;
    [context fillText:string x:x y:y];
    
  }];
}

//- (void) fillText: {
//
//  _scriptcontext = _renderingContext;
//  [_renderingContext fillText:string x:x y:y];
//
//}

RCT_EXPORT_METHOD(strokeText: (nonnull NSNumber *) reactTag string:(NSString *) string x:(float)x y:(float) y) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    //    // context = view.renderingContext;
    [context strokeText:string x:x y:y];
    
  }];
}

//- (void) strokeText:(NSString *) string x:(float)x y:(float) y {
//
//  _scriptcontext = _renderingContext;
//  [_renderingContext strokeText:string x:x y:y];
//
//}

RCT_EXPORT_METHOD(clip: (nonnull NSNumber *) reactTag fillRule:(NSString *) rule) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    EJPathFillRule fillRule = ([rule isEqualToString:@"evenodd"])
    ? kEJPathFillRuleEvenOdd
    : kEJPathFillRuleNonZero;
    
    [context clip:fillRule];
  }];
}

RCT_EXPORT_METHOD(beginPath: (nonnull NSNumber *) reactTag ) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    //    EJPathFillRule fillRule = ([rule isEqualToString:@"evenodd"])
    //    ? kEJPathFillRuleEvenOdd
    //    : kEJPathFillRuleNonZero;
    
    // context = view.renderingContext;
    [context beginPath];
  }];
}

//EJ_BIND_FUNCTION( beginPath, ctx, argc, argv ) {
//	[renderingContext beginPath];
//	return NULL;
//}
////
////EJ_BIND_FUNCTION( closePath, ctx, argc, argv ) {
////	[renderingContext closePath];
////	return NULL;
////}
////
////EJ_BIND_FUNCTION( fill, ctx, argc, argv ) {
////	EJPathFillRule fillRule = (argc > 0 && [JSValueToNSString(ctx, argv[0]) isEqualToString:@"evenodd"])
////		? kEJPathFillRuleEvenOdd
////		: kEJPathFillRuleNonZero;
////
////	scriptcontext = renderingContext;
////	[renderingContext fill:fillRule];
////	return NULL;
////}

//- (void) clip:(NSString *) rule {
//
//  EJPathFillRule fillRule = ([rule isEqualToString:@"evenodd"])
//		? kEJPathFillRuleEvenOdd
//		: kEJPathFillRuleNonZero;
//
//  _scriptcontext = _renderingContext;
//  [_renderingContext clip:fillRule];
//
//}

RCT_EXPORT_METHOD(resetClip: (nonnull NSNumber *) reactTag ) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    // context = view.renderingContext;
    [context resetClip];
  }];
}



////
// Getters / Setters
///



////EJ_BIND_GET(fillStyle, ctx ) {
////	if( renderingContext.fillObject ) {
////		if( [renderingContext.fillObject isKindOfClass:EJCanvasPattern.class] ) {
////			EJCanvasPattern *pattern = (EJCanvasPattern *)renderingContext.fillObject;
////			return [EJBindingCanvasPattern createJSObjectWithContext:ctx scriptView:scriptView pattern:pattern];
////		}
////		else if( [renderingContext.fillObject isKindOfClass:EJCanvasGradient.class] ) {
////			EJCanvasGradient *gradient = (EJCanvasGradient *)renderingContext.fillObject;
////			return [EJBindingCanvasGradient createJSObjectWithContext:ctx scriptView:scriptView gradient:gradient];
////		}
////	}
////	else {
////		return ColorRGBAToJSValue(ctx, renderingContext.state->fillColor);
////	}
////
////	return NULL;
////}

RCT_EXPORT_METHOD(setFillStyle: (nonnull NSNumber *) reactTag dictionary:(NSDictionary*) json ) {
  
  NSLog(@"was NSDictionary!");
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
//    if( JSValueIsObject(ctx, value) ) {
//      		// Try CanvasPattern or CanvasGradient
//      
//      NSObject<EJFillable> *fillable;
//      
//      if( (fillable = [EJBindingCanvasPattern patternFromJSValue:value]) ) {
//        
//        renderingContext.fillObject = fillable;
//      
//      }
//      else if( (fillable = [EJBindingCanvasGradient gradientFromJSValue:value]) ) {
//        
//        //+ (EJCanvasGradient *)gradientFromJSValue:(JSValueRef)value {
//        //	if( !value ) { return NULL; }
//        //
//        //	EJBindingCanvasGradient *binding = (__bridge EJBindingCanvasGradient *)JSValueGetPrivate(value);
//        
//        //	return (binding && [binding isKindOfClass:EJBindingCanvasGradient.class]) ? binding->gradient : NULL;
//        
//        //}
//        
//        renderingContext.fillObject = fillable;
//      
//      }
//    }
//    else {
//      // Should be a color string
//      context.state->fillColor = ValueToColorRGBA(value);
//      context.fillObject = NULL;
//    }

    
  }];
}

////EJ_BIND_GET(strokeStyle, ctx ) {
////	if( renderingContext.strokeObject ) {
////		if( [renderingContext.strokeObject isKindOfClass:EJCanvasPattern.class] ) {
////			EJCanvasPattern *pattern = (EJCanvasPattern *)renderingContext.strokeObject;
////			return [EJBindingCanvasPattern createJSObjectWithContext:ctx scriptView:scriptView pattern:pattern];
////		}
////		else if( [renderingContext.strokeObject isKindOfClass:EJCanvasGradient.class] ) {
////			EJCanvasGradient *gradient = (EJCanvasGradient *)renderingContext.strokeObject;
////			return [EJBindingCanvasGradient createJSObjectWithContext:ctx scriptView:scriptView gradient:gradient];
////		}
////	}
////	else {
////		return ColorRGBAToJSValue(ctx, renderingContext.state->strokeColor);
////	}
////
////	return NULL;
////}

RCT_EXPORT_METHOD(setStrokeStyle: (nonnull NSNumber *) reactTag value:(NSString*) value ) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    //    	if( JSValueIsObject(ctx, value) ) {
    //    		// Try CanvasPattern or CanvasGradient
    //
    //    		NSObject<EJFillable> *fillable;
    //    		if( (fillable = [EJBindingCanvasPattern patternFromJSValue:value]) ) {
    //    			renderingContext.strokeObject = fillable;
    //    		}
    //    		else if( (fillable = [EJBindingCanvasGradient gradientFromJSValue:value]) ) {
    //    			renderingContext.strokeObject = fillable;
    //    		}
    //    	}
    //    	else {
    // Should be a color string
    context.state->strokeColor = ValueToColorRGBA(value);
    context.strokeObject = NULL;
    //    	}
    
  }];
}

//
////EJ_BIND_GET(globalAlpha, ctx ) {
////	return JSValueMakeNumber(ctx, renderingContext.state->globalAlpha );
////}
////
////EJ_BIND_SET(globalAlpha, ctx, value) {
////	renderingContext.state->globalAlpha = MIN(1,MAX(JSValueToNumberFast(ctx, value),0));
////}
RCT_EXPORT_METHOD(setGlobalAlpha: (nonnull NSNumber *) reactTag value:(float) value ) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    context.state->globalAlpha = MIN(1,MAX(value,0));
    
  }];
  
}

////
////EJ_BIND_GET(lineWidth, ctx) {
////	return JSValueMakeNumber(ctx, renderingContext.state->lineWidth);
////}
////
////EJ_BIND_SET(lineWidth, ctx, value) {
////	renderingContext.state->lineWidth = JSValueToNumberFast(ctx, value);
////}

RCT_EXPORT_METHOD(setLineWidth: (nonnull NSNumber *) reactTag value:(float) value ) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    context.state->lineWidth = value;
    
  }];
}

////
////EJ_BIND_GET(miterLimit, ctx) {
////	return JSValueMakeNumber(ctx, renderingContext.state->miterLimit);
////}
////
////EJ_BIND_SET(miterLimit, ctx, value) {
////	renderingContext.state->miterLimit = JSValueToNumberFast(ctx, value);
////}

RCT_EXPORT_METHOD(setMiterLimit: (nonnull NSNumber *) reactTag value:(float) value ) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    context.state->miterLimit = value;
    
  }];
}

////
////EJ_BIND_GET(font, ctx) {
////	EJFontDescriptor *font = renderingContext.state->font;
////	NSString *name = [NSString stringWithFormat:@"%dpx %@", (int)font.size, font.name];
////	return NSStringToJSValue(ctx, name);
////}
////
////EJ_BIND_SET(font, ctx, value) {
////	char string[64]; // Long font names are long
////	JSStringRef jsString = JSValueToStringCopy( ctx, value, NULL );
////	JSStringGetUTF8CString(jsString, string, 64);
////
////	// Yeah, oldschool!
////	float size = 0;
////	char name[64];
////	char ptx;
////	char *start = string;
////	while(*start != '\0' && !isdigit(*start)){ start++; } // skip to the first digit
////	sscanf( start, "%fp%1[tx]%*[\"' ]%63[^\"']", &size, &ptx, name); // matches: 10.5p[tx] 'some font'
////
////	if( ptx == 't' ) { // pt or px?
////		size = ceilf(size*4.0/3.0);
////	}
////
////	EJFontDescriptor *font = [EJFontDescriptor descriptorWithName:@(name) size:size];
////	if( font ) {
////		renderingContext.font = font;
////	}
////	else if( size ) {
////		// Font name not found, but we have a size? Use the current font and just change the size
////		renderingContext.font = [EJFontDescriptor descriptorWithName:renderingContext.font.name size:size];
////	}
////
////	JSStringRelease(jsString);
////}


RCT_EXPORT_METHOD(setFont: (nonnull NSNumber *) reactTag value:(NSString*) value ) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    // Yeah, oldschool!
    float size = 0;
    char name[64];
    char ptx;
    char *start = [value UTF8String];
    while(*start != '\0' && !isdigit(*start)){ start++; } // skip to the first digit
    sscanf( start, "%fp%1[tx]%*[\"' ]%63[^\"']", &size, &ptx, name); // matches: 10.5p[tx] 'some font'
    
    if( ptx == 't' ) { // pt or px?
    		size = ceilf(size*4.0/3.0);
    }
    
    EJFontDescriptor *font = [EJFontDescriptor descriptorWithName:@(name) size:size];
    if( font ) {
    		context.font = font;
    }
    else if( size ) {
    		// Font name not found, but we have a size? Use the current font and just change the size
    		context.font = [EJFontDescriptor descriptorWithName:context.font.name size:size];
    }
    
  }];
}

//
////EJ_BIND_SET(imageSmoothingEnabled, ctx, value) {
////	scriptView.currentRenderingContext = renderingContext;
////	renderingContext.imageSmoothingEnabled = JSValueToBoolean(ctx, value);
////}

RCT_EXPORT_METHOD(setImageSmoothingEnabled: (nonnull NSNumber *) reactTag value: (bool) enabled ) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    context.imageSmoothingEnabled = enabled;
    
  }];
}

////EJ_BIND_GET(imageSmoothingEnabled, ctx) {
////	return JSValueMakeBoolean(ctx, renderingContext.imageSmoothingEnabled);
////}


////
// Enumerables
////


RCT_EXPORT_METHOD(setGlobalCompositeOperation: (nonnull NSNumber *) reactTag value: (NSString*) operation ) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    // TODO find a proper solution to this.
    NSDictionary *compositeOperation = @{@"source-over": @(kEJCompositeOperationSourceOver),
                                         @"lighter": @(kEJCompositeOperationLighter),
                                         @"lighten": @(kEJCompositeOperationLighten),
                                         @"darker": @(kEJCompositeOperationDarker),
                                         @"darken": @(kEJCompositeOperationDarken),
                                         @"destination-out": @(kEJCompositeOperationDestinationOut),
                                         @"destination-over": @(kEJCompositeOperationDestinationOver),
                                         @"source-atop": @(kEJCompositeOperationSourceAtop),
                                         @"xor": @(kEJCompositeOperationXOR),
                                         @"copy": @(kEJCompositeOperationCopy),
                                         @"source-in": @(kEJCompositeOperationSourceIn),
                                         @"destination-in": @(kEJCompositeOperationDestinationIn),
                                         @"source-out": @(kEJCompositeOperationSourceOut),
                                         @"destination-atop": @(kEJCompositeOperationDestinationAtop),
                                         };
    
    NSLog(@"compositeOperation: %@",compositeOperation[operation]);
    
    context.globalCompositeOperation = (EJCompositeOperation) compositeOperation[operation];
    
  }];
}

////EJ_BIND_ENUM(globalCompositeOperation, renderingContext.globalCompositeOperation,
////	"source-over",		// kEJCompositeOperationSourceOver
////	"lighter",			// kEJCompositeOperationLighter
////	"lighten",			// kEJCompositeOperationLighten
////	"darker",			// kEJCompositeOperationDarker
////	"darken",			// kEJCompositeOperationDarken
////	"destination-out",	// kEJCompositeOperationDestinationOut
////	"destination-over",	// kEJCompositeOperationDestinationOver
////	"source-atop",		// kEJCompositeOperationSourceAtop
////	"xor",				// kEJCompositeOperationXOR
////	"copy",				// kEJCompositeOperationCopy
////	"source-in",		// kEJCompositeOperationSourceIn
////	"destination-in",	// kEJCompositeOperationDestinationIn
////	"source-out",		// kEJCompositeOperationSourceOut
////	"destination-atop"	// kEJCompositeOperationDestinationAtop
////);
////

RCT_EXPORT_METHOD(setLineCap: (nonnull NSNumber *) reactTag value: (NSString*) cap ) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    // TODO find a proper solution to this.
    NSDictionary *lineCap = @{@"butt": @(kEJLineCapButt),
                              @"round": @(kEJLineCapRound),
                              @"square": @(kEJLineCapSquare),
                              };
    
    context.state->lineCap = (EJLineCap) lineCap[cap];
    
  }];
}

////EJ_BIND_ENUM(lineCap, renderingContext.state->lineCap,
////	"butt",		// kEJLineCapButt
////	"round",	// kEJLineCapRound
////	"square"	// kEJLineCapSquare
////);
////

RCT_EXPORT_METHOD(setLineJoin: (nonnull NSNumber *) reactTag value: (NSString*) join ) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    // TODO find a proper solution to this.
    NSDictionary *lineJoin = @{@"miter": @(kEJLineJoinMiter),
                              @"bevel": @(kEJLineJoinBevel),
                              @"round": @(kEJLineJoinRound),
                              };
    
    context.state->lineJoin = (EJLineJoin) lineJoin[join];
    
  }];
}

////EJ_BIND_ENUM(lineJoin, renderingContext.state->lineJoin,
////	"miter",	// kEJLineJoinMiter
////	"bevel",	// kEJLineJoinBevel
////	"round"		// kEJLineJoinRound
////);
////

RCT_EXPORT_METHOD(setTextAlign: (nonnull NSNumber *) reactTag value: (NSString*) value ) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    // TODO find a proper solution to this.
    NSDictionary *textAlign = @{@"start": @(kEJTextAlignStart),
                               @"end": @(kEJTextAlignEnd),
                               @"left": @(kEJTextAlignLeft),
                                @"center": @(kEJTextAlignCenter),
                                @"right": @(kEJTextAlignRight),
                               };
    
    context.state->textAlign = (EJTextAlign) textAlign[value];
    
  }];
}

////EJ_BIND_ENUM(textAlign, renderingContext.state->textAlign,
////	"start",	// kEJTextAlignStart
////	"end",		// kEJTextAlignEnd
////	"left",		// kEJTextAlignLeft
////	"center",	// kEJTextAlignCenter
////	"right"		// kEJTextAlignRight
////);

RCT_EXPORT_METHOD(setTextBaseline: (nonnull NSNumber *) reactTag value: (NSString*) value ) {
  
  [self addRCTUIBlockForTag:reactTag block:^(EJCanvasContext2DScreen *context) {
    
    // TODO find a proper solution to this.
    NSDictionary *textBaseline = @{@"alphabetic": @(kEJTextBaselineAlphabetic),
                                @"middle": @(kEJTextBaselineMiddle),
                                @"top": @(kEJTextBaselineTop),
                                @"hanging": @(kEJTextBaselineHanging),
                                @"bottom": @(kEJTextBaselineBottom),
                                @"ideographic": @(kEJTextBaselineIdeographic),
                                };
    
    context.state->textBaseline = (EJTextBaseline) textBaseline[value];
    
  }];
}

////EJ_BIND_ENUM(textBaseline, renderingContext.state->textBaseline,
////	"alphabetic",	// kEJTextBaselineAlphabetic
////	"middle",		// kEJTextBaselineMiddle
////	"top",			// kEJTextBaselineTop
////	"hanging",		// kEJTextBaselineHanging
////	"bottom",		// kEJTextBaselineBottom
////	"ideographic"	// kEJTextBaselineIdeographic
////);




//- (void) resetClip {
//  _scriptcontext = _renderingContext;
//  [_renderingContext resetClip];
//}


@end
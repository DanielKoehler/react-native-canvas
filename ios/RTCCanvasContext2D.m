//
//  RTCCanvasContext2d.m
//  RNCanvas
//
//  Created by Daniel Koehler on 27/03/2016.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RCTBridgeModule.h"



#import "EJCanvas2DTypes.h"
#import "EJBindingTextMetrics.h"

#import "EJConvertColorRGBA.h"

#import "EJCanvasContext2D.h"
#import "RTCCanvasContext2D.h"

//#import "EJTimerCollection.h"

@implementation RTCCanvasContext2D

//- (void) setOptions: (NSDictionary*) newValue {
//  
//  //  NSDictionary *options = (NSDictionary *) optionsObj;
//  
//  // Only override the default for preserveDrawingBuffer if this options is not undefined.
//  // For Canvas2D this defaults to true, for WebGL it defaults to false.
//  if( _options[@"preserveDrawingBuffer"] ) {
//    _renderingContext.preserveDrawingBuffer = [_options[@"preserveDrawingBuffer"] boolValue];
//  }
//  
//  // If antialias is enabled, figure out the max samples this hardware supports and
//  // clamp the antialiasSamples to it, if present. Otherwise default to 2 samples.
//  if( [_options[@"antialias"] boolValue] ) {
//    
//    int msaaSamples = (int)[_options[@"antialiasSamples"] integerValue];
//    int maxSamples = 2;
//    glGetIntegerv(GL_MAX_SAMPLES_APPLE, &maxSamples);
//    
//    _renderingContext.msaaEnabled = maxSamples > 1;
//    _renderingContext.msaaSamples = MAX(2, MIN(maxSamples, msaaSamples));
//  }
//}

//-(void) ini

-(void)layoutSubviews {
  
  _canvas = [[DKCanvasView alloc] initWithFrame:CGRectMake(0,0, 350, 300)];
  
  [self addSubview:_canvas];
  [_canvas setContextType:@"2d"];
  
  NSLog(@"layoutSubviews");
  _canvas.hasScreenCanvas = true;
  
//
//  [super layoutSubviews];
//  
//  _width = self.frame.size.width;
//  _height = self.frame.size.height;
//  
//  [self setupScriptView];
//  [self initaliseContext];
}




@end

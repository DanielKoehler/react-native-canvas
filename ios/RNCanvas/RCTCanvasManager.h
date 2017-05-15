//
//  RCTCanvasManager.h
//  RNCanvas
//
//  Created by Daniel Koehler on 24/03/2016.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RCTViewManager.h"

#import "EJCanvasContext.h"
#import "EJJavaScriptView.h"

typedef enum {
  kEJCanvasContextModeInvalid,
  kEJCanvasContextMode2D,
  kEJCanvasContextModeWebGL
} EJCanvasContextMode;

typedef enum {
  kEJCanvasImageRenderingAuto,
  kEJCanvasImageRenderingCrispEdges,
  kEJCanvasImageRenderingPixelated
} EJCanvasImageRendering;


@interface RCTCanvasManager : RCTViewManager {
  CGRect style;
  BOOL isScreenCanvas;
  
  EJCanvasContext *renderingContext;
  EJCanvasContextMode contextMode;
  short width, height;
  
  EJCanvasImageRendering imageRendering;
  
}

@property (nonatomic) EJCanvasContext *renderingContext;
@property (nonatomic) EJJavaScriptView *scriptView;

@end

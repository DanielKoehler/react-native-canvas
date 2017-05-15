//
//  RTCCanvasContext2d.h
//  RNCanvas
//
//  Created by Daniel Koehler on 27/03/2016.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EJCanvasContext2DScreen.h"
#import "EJCanvasContext2DTexture.h"

#import "DKCanvasView.h"
//#import "EJCanvasContextWebGLScreen.h"
//#import "EJCanvasContextWebGLTexture.h"
#import "EJCanvasContext.h"

//#import "RTCCanvasContext2D.h"


@interface RTCCanvasContext2D : UIView {
  
}

@property (nonatomic) DKCanvasView *canvas;
@property (nonatomic) CGRect style;


@end
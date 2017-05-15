#import "EJCanvasContext.h"
//#import "gl.h"
//#include/
//#include <OpenGLES/OpenGLES.h>

#include <OpenGLES/ES2/gl.h>

@class DKCanvasView;
@interface EJCanvasContextWebGL : EJCanvasContext {
	GLuint viewFrameBuffer, viewRenderBuffer;
	GLuint msaaFrameBuffer, msaaRenderBuffer;
	GLuint boundFrameBuffer, boundRenderBuffer;
	GLuint depthStencilBuffer;
	
	GLint bufferWidth, bufferHeight;
	DKCanvasView *scriptView;
}

- (id)initWithScriptView:(DKCanvasView *)scriptView width:(short)width height:(short)height;
- (void)resizeAuxiliaryBuffers;
- (void)bindFramebuffer:(GLuint)framebuffer toTarget:(GLuint)target;
- (void)bindRenderbuffer:(GLuint)framebuffer toTarget:(GLuint)target;
- (void)create;
- (void)prepare;
- (void)clear;

@property (nonatomic) BOOL needsPresenting;

@end

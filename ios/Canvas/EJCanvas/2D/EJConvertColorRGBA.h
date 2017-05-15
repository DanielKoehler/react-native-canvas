#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "EJCanvas2DTypes.h"

#ifdef __cplusplus
extern "C" {
#endif

EJColorRGBA ValueToColorRGBA(NSString * value);
//JSValueRef ColorRGBAToJSValue( JSContextRef ctx, EJColorRGBA c );

#ifdef __cplusplus
}
#endif
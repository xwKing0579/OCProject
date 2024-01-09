//
//  UIColor+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "UIColor+Category.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation UIColor (Category)
#pragma clang diagnostic pop


+ (BOOL)resolveClassMethod:(SEL)selector{
    NSString *string = NSStringFromSelector(selector);
    if ([string hasPrefix:@"c"] && string.length == 7) {
        Method method = class_getClassMethod([self class],@selector(colorSelf));
        Class metacls = objc_getMetaClass(NSStringFromClass([self class]).UTF8String);
        class_addMethod(metacls,selector,method_getImplementation(method),method_getTypeEncoding(method));
        return YES;
    }
    return [super resolveClassMethod:selector];
}

+ (UIColor *)colorSelf{
    return [self rgbString:NSStringFromSelector(_cmd)];
}

+ (UIColor *)rgbString:(NSString *)cString{
    cString = [cString substringFromIndex:1];
    NSString *rString = [cString substringWithRange:NSMakeRange(0, 2)];
    NSString *gString = [cString substringWithRange:NSMakeRange(2, 2)];
    NSString *bString = [cString substringWithRange:NSMakeRange(4, 2)];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

+ (UIColor *)RGB:(int)rgb {return [self RGB:rgb A:1.0];}
+ (UIColor *)RGB:(int)rgb A:(CGFloat)a {
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:a];
}

- (NSString *)hexStringWithAlpha:(BOOL)withAlpha {
    CGColorRef color = self.CGColor;
    size_t count = CGColorGetNumberOfComponents(color);
    const CGFloat *components = CGColorGetComponents(color);
    static NSString *stringFormat = @"%02x%02x%02x";
    NSString *hex = nil;
    if (count == 2) {
        NSUInteger white = (NSUInteger)(components[0] * 255.0f);
        hex = [NSString stringWithFormat:stringFormat, white, white, white];
    }else if (count == 4) {
        hex = [NSString stringWithFormat:stringFormat,
               (NSUInteger)(components[0] * 255.0f),
               (NSUInteger)(components[1] * 255.0f),
               (NSUInteger)(components[2] * 255.0f)];
    }
    
    if (hex && withAlpha) {
        hex = [hex stringByAppendingFormat:@"%02lx",(unsigned long)(self.alpha * 255.0 + 0.5)];
    }
    return hex;
}

- (CGFloat)alpha{
    return CGColorGetAlpha(self.CGColor);
}

@end


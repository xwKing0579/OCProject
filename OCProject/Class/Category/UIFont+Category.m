//
//  UIFont+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "UIFont+Category.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation UIFont (Category)
#pragma clang diagnostic pop

+ (BOOL)resolveClassMethod:(SEL)selector{
    NSString *string = NSStringFromSelector(selector);
    if ([string hasPrefix:@"font"] && [[string substringFromIndex:string.length-2] isNumber]) {
        Method method = class_getClassMethod([self class],@selector(fontSelf));
        Class metacls = objc_getMetaClass(NSStringFromClass([self class]).UTF8String);
        class_addMethod(metacls,selector,method_getImplementation(method),method_getTypeEncoding(method));
        return YES;
    }
    return [super resolveClassMethod:selector];
}

+ (UIFont *)fontSelf{
    NSString *fontString = NSStringFromSelector(_cmd);
    if ([fontString hasPrefix:@"fontBold"]){
        return [self fontSize:[[fontString stringByReplacingOccurrencesOfString:@"fontBold" withString:@""] floatValue]];
    }
    return [self fontSize:[[fontString stringByReplacingOccurrencesOfString:@"font" withString:@""] floatValue]];
}

+ (UIFont *)fontSize:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
}

+ (UIFont *)fontBoldSize:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
}

@end

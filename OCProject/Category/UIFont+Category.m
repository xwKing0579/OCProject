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
    RESOLVE_CLASS_METHOD([string hasPrefix:@"font"] && [[string substringFromIndex:string.length-2] isNumber], @selector(fontSelf))
    return [super resolveClassMethod:selector];
}

+ (UIFont *)fontSelf{
    NSString *action = @"fontSize:";
    NSString *selector = NSStringFromSelector(_cmd);
    ///这里写死后2位，可以按照实际情况处理
    NSString *font = [selector substringFromIndex:selector.length-2];
    if ([selector hasPrefix:@"fontBold"]){
        action = @"fontBoldSize:";
    }
    return [self performAction:action object:font];
}

+ (UIFont *)fontSize:(NSString *)size{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:size.floatValue];
}

+ (UIFont *)fontBoldSize:(NSString *)size{
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:size.floatValue];
}

@end

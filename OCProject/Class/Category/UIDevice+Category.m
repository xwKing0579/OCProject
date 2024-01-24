//
//  UIDevice+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/11.
//

#import "UIDevice+Category.h"

@implementation UIDevice (Category)

+ (CGFloat)statusBarHeight{
    return [UIViewController window].safeAreaInsets.top;
}

+ (CGFloat)bottomBarHeight{
    return [UIViewController window].safeAreaInsets.bottom;
}
@end

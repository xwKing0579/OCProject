//
//  UIDevice+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/11.
//

#import "UIDevice+Category.h"

@implementation UIDevice (Category)

+ (CGFloat)statusBarHeight{
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
        return statusBarManager.statusBarFrame.size.height;
    }else{
        return [UIApplication sharedApplication].statusBarFrame.size.height;
    }
}

@end

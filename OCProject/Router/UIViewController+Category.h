//
//  UIViewController+Category.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Category)

+ (UIWindow *)window;
+ (__kindof UIViewController *)rootViewController;
+ (__kindof UIViewController *)currentViewController;

///禁止截屏
@property (nonatomic, assign) BOOL isForbidShot;

@end

NS_ASSUME_NONNULL_END

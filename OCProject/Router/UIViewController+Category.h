//
//  UIViewController+Category.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Category)
+ (__kindof UIViewController *)currentViewController;
@end

NS_ASSUME_NONNULL_END

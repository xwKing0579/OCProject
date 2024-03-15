//
//  TPToastManager.h
//  OCProject
//
//  Created by 王祥伟 on 2024/1/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPToastManager : NSObject

///方法名与MBProgressHUD保持一致，不然找不到
+ (void)showLoading;
+ (void)hideLoading;
+ (void)showText:(NSString * _Nullable)text;
+ (void)showLoadingInView:(UIView * _Nullable)view;
+ (void)showText:(NSString * _Nullable)text inView:(UIView *)view;

///特殊情况（比如自定义视图，文字图片混合，自定义时间，空白处可以响应等方法组合太多，不一一列举）
+ (void)showText:(NSString * _Nullable)text inView:(UIView * _Nullable)view enable:(BOOL)enable;
+ (void)showText:(NSString * _Nullable)text inView:(UIView * _Nullable)view enable:(BOOL)enable afterDelay:(NSTimeInterval)afterDelay;

//该方法不存在，仅demo演示使用
+ (void)showLoading2;
@end

NS_ASSUME_NONNULL_END

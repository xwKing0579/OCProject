//
//  UIDevice+Category.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Category)

+ (CGFloat)width;
+ (CGFloat)height;

+ (CGFloat)topHeight;
+ (CGFloat)bottomHeight;

+ (CGFloat)statusBarHeight;
+ (CGFloat)navBarHeight;
+ (CGFloat)tabbarHeight;
+ (CGFloat)bottomBarHeight;

+ (NSString *)bundleName;
+ (NSString *)appName;
+ (NSString *)appBundle;
+ (NSString *)appVersion;
+ (NSString *)appMinSystemVersion;

+ (NSString *)deviceName;
+ (NSString *)deviceModel;
+ (NSString *)deviceSize;
+ (NSString *)deviceScale;
+ (NSString *)systemVersion;
+ (NSString *)systemLanguage;

@end

NS_ASSUME_NONNULL_END

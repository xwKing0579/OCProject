//
//  UIColor+Category.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Category)

+ (UIColor *)cffffff;
+ (UIColor *)ccccccc;
+ (UIColor *)c1e1e1e;
+ (UIColor *)c333333;
+ (UIColor *)c505050;
+ (UIColor *)c000000;
+ (UIColor *)c1296db;
+ (UIColor *)cbfbfbf;
+ (UIColor *)c1eb65f;
+ (UIColor *)cff5a00;


+ (UIColor *)rgbString:(NSString *)cString;
- (NSString *)hexStringWithAlpha:(BOOL)withAlpha;

@end

NS_ASSUME_NONNULL_END

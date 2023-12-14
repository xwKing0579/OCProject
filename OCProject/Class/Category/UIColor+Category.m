//
//  UIColor+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

+ (UIColor *)cFFFFFF{return [self RGB:0xFFFFFF];}
+ (UIColor *)cCCCCCC{return [self RGB:0xCCCCCC];}
+ (UIColor *)c333333{return [self RGB:0x333333];}
+ (UIColor *)c000000{return [self RGB:0x000000];}
+ (UIColor *)c1EB65F{return [self RGB:0x1EB65F];}

+ (UIColor *)RGB:(int)rgb{return [self RGB:rgb A:1.0];}
+ (UIColor *)RGB:(int)rgb A:(CGFloat)a{
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:a];
}

@end

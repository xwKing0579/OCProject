//
//  UIImage+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)
- (UIImage *)original{
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
}

+ (UIImage *)createImageWithColor:(UIColor *)color{
    return [self createImageWithColor:color size:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end

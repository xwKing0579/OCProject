//
//  UIView+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/7.
//

#import "UIView+Category.h"
#import <objc/runtime.h>

@implementation UIView (Category)

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)addSubviews:(NSArray *)views{
    for (UIView *subview in views) {
        [self addSubview:subview];
    }
}

- (void)removeAllSubView{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)removeAllSubViewExcept:(NSArray *)views{
    NSArray *arraySubViews = [NSArray arrayWithArray:self.subviews];
    for (UIView *subview in arraySubViews) {
        if (![views containsObject:subview]) {
            [subview removeFromSuperview];
        }
    }
}

- (UIImage *)toImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}
@end

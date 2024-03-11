//
//  UIAlertController+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/11.
//

#import "UIAlertController+Category.h"

@implementation UIAlertController (Category)

+ (instancetype)alertTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message cancel:(NSString *)cancel cancelBlock:(cancelBlock _Nullable)cancelBlock{
    return [self alertTitle:title message:message cancel:cancel cancelBlock:cancelBlock confirm:nil confirmBlock:nil];
}

+ (instancetype)alertTitle:(NSString * _Nullable)title message:(NSString * __nullable)message cancel:(NSString *)cancel cancelBlock:(cancelBlock _Nullable)cancelBlock confirm:(NSString * _Nullable)confirm confirmBlock:(confirmBlock  _Nullable)confirmBlock{
    return [self alertStyle:UIAlertControllerStyleAlert title:title message:message cancel:cancel cancelBlock:cancelBlock confirms:confirm ? @[confirm] : nil confirmBlock:confirmBlock];
}

+ (instancetype)alertStyle:(UIAlertControllerStyle)style title:(NSString * _Nullable)title message:(NSString * __nullable)message cancel:(NSString *)cancel cancelBlock:(cancelBlock _Nullable)cancelBlock confirms:(NSArray <NSString *>* _Nullable)confirm confirmBlock:(confirmBlock _Nullable)confirmBlock{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    if (cancel.length) {
        [alertVC addAction:[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) cancelBlock(action.title);
        }]];
    }
    
    [confirm enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alertVC addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmBlock) confirmBlock(idx);
        }]];
    }];
    return alertVC;
}

@end

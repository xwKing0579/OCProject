//
//  UIAlertController+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/11.
//

#import "UIAlertController+Category.h"

@implementation UIAlertController (Category)

+ (instancetype)alertTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel cancelBlock:(cancelBlock)cancelBlock{
    return [self alertTitle:title message:message cancel:cancel cancelBlock:cancelBlock confirm:nil confirmBlock:nil];
}

+ (instancetype)alertTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel cancelBlock:(cancelBlock)cancelBlock confirm:(NSString *)confirm confirmBlock:(confirmBlock)confirmBlock{
    return [self alertStyle:UIAlertControllerStyleAlert title:title message:message cancel:cancel cancelBlock:cancelBlock confirm:confirm ? @[confirm] : nil confirmBlock:confirmBlock];
}

+ (instancetype)alertStyle:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel cancelBlock:(cancelBlock)cancelBlock confirm:(NSArray *)confirm confirmBlock:(confirmBlock)confirmBlock{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    if (cancel.length) {
        [alertVC addAction:[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) cancelBlock(action.title);
        }]];
    }
    
    [confirm enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alertVC addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmBlock) confirmBlock(idx);
        }]];
    }];
    return alertVC;
}

@end

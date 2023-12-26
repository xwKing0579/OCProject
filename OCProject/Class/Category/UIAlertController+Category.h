//
//  UIAlertController+Category.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^confirmBlock)(NSUInteger index);
typedef void (^cancelBlock)(NSString *cancel);

@interface UIAlertController (Category)

+ (instancetype)alertTitle:(NSString *)title message:( NSString * _Nullable)message cancel:(NSString *)cancel cancelBlock:(cancelBlock)cancelBlock;
+ (instancetype)alertTitle:(NSString *)title message:(NSString * __nullable)message cancel:(NSString *)cancel cancelBlock:(cancelBlock)cancelBlock confirm:(NSString *)confirm confirmBlock:(confirmBlock)confirmBlock;
+ (instancetype)alertStyle:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString * __nullable)message cancel:(NSString *)cancel cancelBlock:(cancelBlock)cancelBlock confirm:(NSArray <NSString *>*)confirm confirmBlock:(confirmBlock)confirmBlock;

@end

NS_ASSUME_NONNULL_END

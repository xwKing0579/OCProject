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

+ (instancetype)alertTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message cancel:(NSString *)cancel cancelBlock:(cancelBlock _Nullable)cancelBlock;
+ (instancetype)alertTitle:(NSString * _Nullable)title message:(NSString * __nullable)message cancel:(NSString *)cancel cancelBlock:(cancelBlock _Nullable)cancelBlock confirm:(NSString * _Nullable)confirm confirmBlock:(confirmBlock  _Nullable)confirmBlock;
+ (instancetype)alertStyle:(UIAlertControllerStyle)style title:(NSString * _Nullable)title message:(NSString * __nullable)message cancel:(NSString *)cancel cancelBlock:(cancelBlock _Nullable)cancelBlock confirms:(NSArray <NSString *>* _Nullable)confirm confirmBlock:(confirmBlock _Nullable)confirmBlock;

@end

NS_ASSUME_NONNULL_END

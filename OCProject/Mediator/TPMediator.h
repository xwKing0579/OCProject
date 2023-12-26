//
//  TPMediator.h
//  Router
//
//  Created by 王祥伟 on 2023/11/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString *const kTPMediatorClassObjectName;
FOUNDATION_EXTERN NSString *const kTPMediatorActionObjectName;

@interface TPMediator : NSObject

///不支持返回基础数据类型
+ (id)performTarget:(NSString *)target action:(NSString *)action;
+ (id)performTarget:(NSString *)target action:(NSString *)action object:(id)object;

/**
 中间件
 
 @param target 类名  注意：类方法需要添加前缀 kTPMediatorClassObjectName 即 ‘class.’
 @param action 方法名
 @param object1 第一参数，object2 第二参数
 
 @return id
 */
+ (id)performTarget:(NSString *)target action:(NSString *)action object:(id)object1 object:(id)object2;

/**
 @param objects 非空参数集合，某方法需要多参时使用  objects
    参数名命名规则 kTPMediatorActionObjectName + <n>
  eg: @{@"object1":@“参数一”,
      @"object2":@“参数二”,
      @"object3":@“参数三”,
                   .......}
 */
+ (id)performTarget:(NSString *)target action:(NSString *)action objects:(NSDictionary *)objects;
+ (id)safePerformTarget:(id)target selector:(SEL)selector objects:(NSDictionary *)objects;
@end

NS_ASSUME_NONNULL_END

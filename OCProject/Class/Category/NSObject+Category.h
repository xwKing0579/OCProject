//
//  NSObject+Category.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Category)

+ (void)swizzleClassMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector;
- (void)swizzleInstanceMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector;

- (NSArray <NSDictionary *>*)propertyList;
- (NSArray <NSDictionary *>*)customPropertyList:(NSArray <NSString *>*)properties;


- (id)performAction:(NSString *)action;
- (id)performAction:(NSString *)action object:(id __nullable)object;
- (id)performAction:(NSString *)action object:(id __nullable)object1 object:(id __nullable)object2;
- (id)performAction:(NSString *)action objects:(NSDictionary * __nullable)objects;

+ (id)performAction:(NSString *)action;
+ (id)performAction:(NSString *)action object:(id __nullable)object;
+ (id)performAction:(NSString *)action object:(id __nullable)object1 object:(id __nullable)object2;
+ (id)performAction:(NSString *)action objects:(NSDictionary * __nullable)objects;

///注意 不支持返回基础数据类型
///注意 不支持返回基础数据类型
///注意 不支持返回基础数据类型
+ (id)performTarget:(NSString *)target action:(NSString *)action;
+ (id)performTarget:(NSString *)target action:(NSString *)action object:(id __nullable)object;

/**
 中间件
 
 @param target 类名  注意：类方法需要添加前缀 kNSObjectClassObjectName 即 ‘class.’
 @param action 方法名
 @param object1 第一参数，object2 第二参数
 
 @return id
 */
+ (id)performTarget:(NSString *)target action:(NSString *)action object:(id __nullable)object1 object:(id __nullable)object2;

/**
 @param objects 非空参数集合，某方法需要多参时使用  objects
    参数名命名规则 kNSObjectActionObjectName + <n>
  eg: @{@"object1":@“参数一”,
      @"object2":@“参数二”,
      @"object3":@“参数三”,
                   .......}
 */
+ (id)performTarget:(NSString *)target action:(NSString *)action objects:(NSDictionary * __nullable)objects;

@end

NS_ASSUME_NONNULL_END

//
//  NSObject+Mediator.h
//  OCProject
//
//  Created by 王祥伟 on 2024/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXTERN NSString *const kNSObjectClassObjectName;
@interface NSObject (Mediator)

- (id)performAction:(NSString *)action;
- (id)performAction:(NSString *)action object:(id __nullable)object;
- (id)performAction:(NSString *)action object:(id __nullable)object1 object:(id __nullable)object2;
- (id)performAction:(NSString *)action objects:(NSDictionary * __nullable)objects;

+ (id)performAction:(NSString *)action;
+ (id)performAction:(NSString *)action object:(id __nullable)object;
+ (id)performAction:(NSString *)action object:(id __nullable)object1 object:(id __nullable)object2;
+ (id)performAction:(NSString *)action objects:(NSDictionary * __nullable)objects;

+ (id)performTarget:(NSString *)target action:(NSString *)action;
+ (id)performTarget:(NSString *)target action:(NSString *)action object:(id __nullable)object;
+ (id)performTarget:(NSString *)target action:(NSString *)action object:(id __nullable)object1 object:(id __nullable)object2;
+ (id)performTarget:(NSString *)target action:(NSString *)action objects:(NSDictionary * __nullable)objects;

@end

@interface NSString (Mediator)
- (NSString *)classString;
@end

NS_ASSUME_NONNULL_END

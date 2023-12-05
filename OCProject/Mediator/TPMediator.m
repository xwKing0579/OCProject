//
//  TPMediator.m
//  Router
//
//  Created by 王祥伟 on 2023/11/24.
//

#import "TPMediator.h"

NSString *const kTPMediatorClassObjectName = @"_Class";
NSString *const kTPMediatorActionObjectName = @"object";

#ifdef DEBUG
#define TPLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])//__PRETTY_FUNCTION__
#else
#define TPLog(...)

#endif

@implementation TPMediator

#pragma mark - public methods
+ (id)performTarget:(NSString *)target action:(NSString *)action {
    return [self performTarget:target action:action objects:@{}];
}

+ (id)performTarget:(NSString *)target action:(NSString *)action object:(id)object {
    NSMutableDictionary *objects = [NSMutableDictionary dictionary];
    [objects setValue:object forKey:[kTPMediatorActionObjectName stringByAppendingString:@"1"]];
    return [self performTarget:target action:action objects:objects];
}

+ (id)performTarget:(NSString *)target action:(NSString *)action object:(id)object1 object:(id)object2{
    NSMutableDictionary *objects = [NSMutableDictionary dictionary];
    [objects setValue:object1 forKey:[kTPMediatorActionObjectName stringByAppendingString:@"1"]];
    [objects setValue:object2 forKey:[kTPMediatorActionObjectName stringByAppendingString:@"2"]];
    return [self performTarget:target action:action objects:objects];
}

+ (id)performTarget:(NSString *)target action:(NSString *)action objects:(NSDictionary *)objects{
    if (!(target && action)) return nil;
    
    id targetObject = nil;
    if ([target hasSuffix:kTPMediatorClassObjectName]) {
        targetObject = NSClassFromString([target stringByReplacingOccurrencesOfString:kTPMediatorClassObjectName withString:@""]);
    }else{
        targetObject = [[NSClassFromString(target) alloc] init];
    }
    
    SEL selector = NSSelectorFromString(action);

    if ([targetObject respondsToSelector:selector]) {
        return [self safePerformTarget:targetObject selector:selector objects:objects];
    }else{
        [self noTarget:target action:action targetObject:targetObject];
        return nil;
    }
}

+ (id)safePerformTarget:(id)target selector:(SEL)selector objects:(NSDictionary *)objects{
    NSMethodSignature *methodSig = [target methodSignatureForSelector:selector];
    if(methodSig == nil) {
        return nil;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    [invocation setSelector:selector];
    [invocation setTarget:target];
    NSArray *allkeys = objects.allKeys;
    for (NSString *key in allkeys) {
        if ([key hasPrefix:kTPMediatorActionObjectName]) {
            NSUInteger idx = [[key stringByReplacingOccurrencesOfString:kTPMediatorActionObjectName withString:@""] intValue] + 1;
            if (methodSig.numberOfArguments > idx) {
                id obj = objects[key];
                [invocation setArgument:&obj atIndex:idx];
            }
        }
    }
    [invocation invoke];
    
    const char *retType = [methodSig methodReturnType];
    if (strcmp(methodSig.methodReturnType, "@") == 0) {
        void *result = NULL;
        [invocation getReturnValue:&result];
        return (__bridge id)(result);
    }else if (strcmp(retType, @encode(NSInteger)) == 0) {
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }else if (strcmp(retType, @encode(BOOL)) == 0){
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }else if (strcmp(retType, @encode(CGFloat)) == 0){
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }else if (strcmp(retType, @encode(NSUInteger)) == 0){
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    return nil;
}

#pragma mark - private methods
+ (void)noTarget:(NSString *)target action:(NSString *)action targetObject:(id)targetObject{
    if (targetObject) {
        if ([target hasSuffix:kTPMediatorClassObjectName]) {
            target = [target stringByReplacingOccurrencesOfString:kTPMediatorClassObjectName withString:@""];
            TPLog(@"%@", [NSString stringWithFormat:@"Method not found，请检查类<%@>中类方法<%@>是否存在",target,action]);
        }else{
            TPLog(@"%@", [NSString stringWithFormat:@"Method not found，请检查类<%@>中实例方法<%@>是否存在",target,action]);
        }
    }else{
        if ([target hasSuffix:kTPMediatorClassObjectName]) {
            target = [target stringByReplacingOccurrencesOfString:kTPMediatorClassObjectName withString:@""];
        }
        TPLog(@"%@", [NSString stringWithFormat:@"target not found，请检查类<%@>是否存在",target]);
    }
}

@end


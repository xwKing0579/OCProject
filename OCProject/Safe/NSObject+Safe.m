//
//  NSObject+Safe.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/11.
//

#import "NSObject+Safe.h"
#import "TPSafeObjectManager.h"

@implementation NSObject (Safe)
+ (void)load{
#if RELEASE
    [self safeSwitch];
#endif
}

+ (void)safeSwitch{
    ///这里简单hook常用方法
    [NSObject swizzleInstanceMethod:@selector(valueForKey:)
                  withSwizzleMethod:@selector(safe_valueForKey:)];
    
    Class __NSArray0 = objc_getClass("__NSArray0");
    Class __NSArrayI = objc_getClass("__NSArrayI");
    Class __NSArrayM = objc_getClass("__NSArrayM");
    Class __NSSingleArrayI = objc_getClass("__NSSingleObjectArrayI");
    
    [__NSArray0 exchangeInstanceSelector:@selector(objectAtIndex:) toSelector:@selector(safe_objectAtIndex:)];
    [__NSArrayI exchangeInstanceSelector:@selector(objectAtIndex:) toSelector:@selector(safe_I_objectAtIndex:)];
    [__NSArrayM exchangeInstanceSelector:@selector(objectAtIndex:) toSelector:@selector(safe_M_objectAtIndex:)];
    [__NSSingleArrayI exchangeInstanceSelector:@selector(objectAtIndex:) toSelector:@selector(safe_S_objectAtIndex:)];
    
    [__NSArrayI exchangeInstanceSelector:@selector(objectAtIndexedSubscript:) toSelector:@selector(safe_I_objectAtIndexedSubscript:)];
    [__NSArrayM exchangeInstanceSelector:@selector(objectAtIndexedSubscript:) toSelector:@selector(safe_M_objectAtIndexedSubscript:)];
    
    [__NSArrayM exchangeInstanceSelector:@selector(removeObjectAtIndex:) toSelector:@selector(safe_removeObjectAtIndex:)];
    [__NSArrayM exchangeInstanceSelector:@selector(insertObject:atIndex:) toSelector:@selector(safe_insertObject:atIndex:)];
    [__NSArrayM exchangeInstanceSelector:@selector(setObject:atIndexedSubscript:) toSelector:@selector(safe_setObject:atIndexedSubscript:)];
    
    Class __NSDictionaryM = objc_getClass("__NSDictionaryM");
    [__NSDictionaryM exchangeInstanceSelector:@selector(setObject:forKey:) toSelector:@selector(safe_setObject:forKey:)];
//    [__NSDictionaryM exchangeInstanceSelector:@selector(removeObjectForKey:) toSelector:@selector(safe_removeObjectForKey:)];
}


- (id)safe_valueForKey:(NSString *)key{
    id object = nil;
    @try {
        object = [self safe_valueForKey:key];
    }@catch (NSException *exception) {
        [TPSafeObjectManager safeObjectWithException:exception];
    }@finally {
        return object;
    }
}

- (id)safe_objectAtIndex:(NSUInteger)index{
    id object = nil;
    @try {
        object = [self safe_objectAtIndex:index];
    }@catch (NSException *exception) {
        [TPSafeObjectManager safeObjectWithException:exception];
    }@finally {
        return object;
    }
}

- (id)safe_I_objectAtIndex:(NSUInteger)index{
    id object = nil;
    @try {
        object = [self safe_I_objectAtIndex:index];
    }@catch (NSException *exception) {
        [TPSafeObjectManager safeObjectWithException:exception];
    }@finally {
        return object;
    }
}

- (id)safe_M_objectAtIndex:(NSUInteger)index{
    id object = nil;
    @try {
        object = [self safe_M_objectAtIndex:index];
    }@catch (NSException *exception) {
        [TPSafeObjectManager safeObjectWithException:exception];
    }@finally {
        return object;
    }
}

- (id)safe_S_objectAtIndex:(NSUInteger)index{
    id object = nil;
    @try {
        object = [self safe_S_objectAtIndex:index];
    }@catch (NSException *exception) {
        [TPSafeObjectManager safeObjectWithException:exception];
    }@finally {
        return object;
    }
}

- (id)safe_I_objectAtIndexedSubscript:(NSUInteger)index{
    id object = nil;
    @try {
        object = [self safe_I_objectAtIndexedSubscript:index];
    }@catch (NSException *exception) {
        [TPSafeObjectManager safeObjectWithException:exception];
    }@finally {
        return object;
    }
}

- (id)safe_M_objectAtIndexedSubscript:(NSUInteger)index{
    id object = nil;
    @try {
        object = [self safe_M_objectAtIndexedSubscript:index];
    }@catch (NSException *exception) {
        [TPSafeObjectManager safeObjectWithException:exception];
    }@finally {
        return object;
    }
}

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index{
    @try {
        [self safe_insertObject:anObject atIndex:index];
    }@catch (NSException *exception) {
        [TPSafeObjectManager safeObjectWithException:exception];
    }@finally {
        
    }
}

- (void)safe_removeObjectAtIndex:(NSUInteger)index{
    @try {
        [self safe_removeObjectAtIndex:index];
    }@catch (NSException *exception) {
        [TPSafeObjectManager safeObjectWithException:exception];
    }@finally {
        
    }
}

- (void)safe_setObject:(id)anObject atIndexedSubscript:(NSUInteger)idx{
    @try {
        [self safe_setObject:anObject atIndexedSubscript:idx];
    }@catch (NSException *exception) {
        [TPSafeObjectManager safeObjectWithException:exception];
    }@finally {
        
    }
}

- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)key{
    @try {
        [self safe_setObject:anObject forKey:key];
    }@catch (NSException *exception) {
        [TPSafeObjectManager safeObjectWithException:exception];
    }@finally {
        
    }
}

- (void)exchangeInstanceSelector:(SEL)selector toSelector:(SEL)toSelector{
    Class class = [self class];
    Method method = class_getInstanceMethod(class, selector);
    Method toMethod = class_getInstanceMethod(class, toSelector);
   
    if (class_addMethod(class,selector,method_getImplementation(toMethod),method_getTypeEncoding(toMethod))) {
        class_replaceMethod(class,toSelector,method_getImplementation(method),method_getTypeEncoding(method));
    }else {
        method_exchangeImplementations(method, toMethod);
    }
}
@end

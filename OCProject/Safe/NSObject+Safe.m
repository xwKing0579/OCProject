//
//  NSObject+Safe.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/11.
//

#import "NSObject+Safe.h"

@implementation NSObject (Safe)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject swizzleInstanceMethod:@selector(valueForKey:) 
                      withSwizzleMethod:@selector(safe_valueForKey:)];
        [NSClassFromString(@"__NSArrayM") swizzleInstanceMethod:@selector(objectAtIndex:)
                                              withSwizzleMethod:@selector(safe_objectAtIndex:)];
    });
}

- (id)safe_valueForKey:(NSString *)key{
    id object = nil;
    @try {
        object = [self safe_valueForKey:key];
    }@catch (NSException *exception) {
        
    }@finally {
        return object;
    }
}

- (id)safe_objectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self safe_objectAtIndex:index];
    }@catch (NSException *exception) {
        
    }@finally {
        return object;
    }
}

@end

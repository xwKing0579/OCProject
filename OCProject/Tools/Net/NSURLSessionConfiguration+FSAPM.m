//
//  NSURLSessionConfiguration+FSAPM.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/29.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "NSURLSessionConfiguration+FSAPM.h"
#import <objc/runtime.h>
#import "TPURLProtocol.h"

@implementation NSURLSessionConfiguration (FSAPM)

+ (void)load{
#ifdef DEBUG
    Class class = NSClassFromString(@"__NSCFURLSessionConfiguration") ?: NSClassFromString(@"NSURLSessionConfiguration");
    Method method = class_getInstanceMethod(class, @selector(protocolClasses));
    Method swizzleMethod = class_getInstanceMethod(self, @selector(swizzle_protocolClasses));
    if (method && swizzleMethod) {
        if (class_addMethod(class, @selector(protocolClasses), method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))) {
            class_replaceMethod(self, @selector(swizzle_protocolClasses), method_getImplementation(method), method_getTypeEncoding(method));
        } else {
            method_exchangeImplementations(method, swizzleMethod);
        }
    }
#endif
}

- (NSArray<Class> *)swizzle_protocolClasses{
    NSMutableArray *array = [[self swizzle_protocolClasses] mutableCopy];
    if (![array containsObject:[TPURLProtocol class]]) {
        [array insertObject:[TPURLProtocol class] atIndex:0];
    }
    return array;
}

@end

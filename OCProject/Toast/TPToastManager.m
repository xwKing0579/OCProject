//
//  TPToastManager.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/24.
//

#import "TPToastManager.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation TPToastManager
#pragma clang diagnostic pop

+ (BOOL)resolveClassMethod:(SEL)selector{
    NSString *action = NSStringFromSelector(selector);
    NSUInteger count = [action componentsSeparatedByString:@":"].count;
    if (count < 6){
        NSString *toastString = @"toast";
        if (count > 1){
            toastString = @"toastWithObj:";
            for (int i = 2; i < count; i++) {
                toastString = [toastString stringByAppendingString:@"obj:"];
            }
        }
        Method method = class_getClassMethod([self class],NSSelectorFromString(toastString));
        Class metacls = objc_getMetaClass(NSStringFromClass([self class]).UTF8String);
        class_addMethod(metacls,selector,method_getImplementation(method),method_getTypeEncoding(method));
        return YES;
    }
    return [super resolveClassMethod:selector];
}

+ (void)toast{
    [self action:NSStringFromSelector(_cmd) obj:nil obj:nil obj:nil obj:nil];
}

+ (void)toastWithObj:(id)obj{
    [self action:NSStringFromSelector(_cmd) obj:obj obj:nil obj:nil obj:nil];
}

+ (void)toastWithObj:(id)obj1 obj:(id)obj2{
    [self action:NSStringFromSelector(_cmd) obj:obj1 obj:obj2 obj:nil obj:nil];
}

+ (void)toastWithObj:(id)obj1 obj:(id)obj2 obj:(id)obj3{
    [self action:NSStringFromSelector(_cmd) obj:obj1 obj:obj2 obj:obj3 obj:nil];
}

+ (void)toastWithObj:(id)obj1 obj:(id)obj2 obj:(id)obj3 obj:(id)obj4{
    [self action:NSStringFromSelector(_cmd) obj:obj1 obj:obj2 obj:obj3 obj:obj4];
}

+ (void)action:(NSString *)action obj:(id)obj1 obj:(id)obj2 obj:(id)obj3 obj:(id)obj4{
    NSMutableDictionary *objects = [NSMutableDictionary dictionary];
    if (obj1) [objects setValue:obj1 forKey:@"object1"];
    if (obj2) [objects setValue:obj2 forKey:@"object2"];
    if (obj3) [objects setValue:obj3 forKey:@"object3"];
    if (obj4) [objects setValue:obj4 forKey:@"object4"];
    [NSObject performTarget:@"MBProgressHUD_Class" action:action objects:objects];
}

@end

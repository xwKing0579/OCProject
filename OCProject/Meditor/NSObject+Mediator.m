//
//  NSObject+Mediator.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/13.
//

#import "NSObject+Mediator.h"

NSString *const kNSObjectClassObjectName = @"_Class";

#define CASE_TYPE(_typeChar, _type, _method) case _typeChar: ACTION_TYPE(_type, _method)
#define STRUCT_TYPE(_type, _method) if (strcmp(paramType, @encode(_type)) == 0) ACTION_TYPE(_type, _method)
#define STRING_TYPE(_type, _method) if (strcmp(paramType, @encode(_type)) == 0) { _type param = _method; ACTION_SET_ARGUMENT }
#define ACTION_TYPE(_type, _method) { _type param = [value _method]; ACTION_SET_ARGUMENT }
#define ACTION_SET_ARGUMENT [invocation setArgument:&param atIndex:idx]; break;

#define SAFE_PERFORM_SELECTOR SEL sel = NSSelectorFromString(action);\
return [self respondsToSelector:sel] ? [NSObject safePerformTarget:self selector:sel objects:objects] : nil;\

#define CREATE_OBJECTS NSMutableDictionary *objects = [NSMutableDictionary dictionary];\
if(object1) [objects setValue:object1 forKey:@"1"];\
if(object2) [objects setValue:object2 forKey:@"2"];\

@implementation NSObject (Mediator)
- (id)performAction:(NSString *)action{
    return [self performAction:action object:nil];
}

- (id)performAction:(NSString *)action object:(id __nullable)object{
    return [self performAction:action object:object object:nil];
}

- (id)performAction:(NSString *)action object:(id __nullable)object1 object:(id __nullable)object2{
    CREATE_OBJECTS
    return [self performAction:action objects:objects];
}

- (id)performAction:(NSString *)action objects:(NSDictionary * __nullable)objects{
    SAFE_PERFORM_SELECTOR
}

+ (id)performAction:(NSString *)action{
    return [self performAction:action object:nil];
}

+ (id)performAction:(NSString *)action object:(id __nullable)object{
    return [self performAction:action object:object object:nil];
}

+ (id)performAction:(NSString *)action object:(id __nullable)object1 object:(id __nullable)object2{
    CREATE_OBJECTS
    return [self performAction:action objects:objects];
}

+ (id)performAction:(NSString *)action objects:(NSDictionary * __nullable)objects{
    SAFE_PERFORM_SELECTOR
}

#pragma mark - public methods
+ (id)performTarget:(NSString *)target action:(NSString *)action {
    return [self performTarget:target action:action objects:@{}];
}

+ (id)performTarget:(NSString *)target action:(NSString *)action object:(id __nullable)object {
    return [self performTarget:target action:action object:object object:@{}];
}

+ (id)performTarget:(NSString *)target action:(NSString *)action object:(id __nullable)object1 object:(id __nullable)object2{
    CREATE_OBJECTS
    return [self performTarget:target action:action objects:objects];
}

+ (id)performTarget:(NSString *)target action:(NSString *)action objects:(NSDictionary * __nullable)objects{
    if (!(target && action)) return nil;
    
    id targetObject = nil;
    if ([target hasSuffix:kNSObjectClassObjectName]) {
        targetObject = NSClassFromString([target stringByReplacingOccurrencesOfString:kNSObjectClassObjectName withString:@""]);
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

+ (id)safePerformTarget:(id)target selector:(SEL)selector objects:(NSDictionary * __nullable)objects{
    NSMethodSignature *methodSig = [target methodSignatureForSelector:selector];
    if (!methodSig) return nil;
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    [invocation setSelector:selector];
    [invocation setTarget:target];
    
    for (NSString *key in objects.allKeys) {
        NSUInteger idx = [key intValue] + 1;
        if (methodSig.numberOfArguments > idx) {
            id obj = objects[key];
            char paramType[255];
            strcpy(paramType, [methodSig getArgumentTypeAtIndex:idx]);
            if (strncmp(paramType, "@", 1) == 0) {
                [invocation setArgument:&obj atIndex:idx];
            }else{
                char type = paramType[0] == 'r' ? paramType[1] : paramType[0];
                
                if ([obj isKindOfClass:[NSNumber class]]) {
                    NSNumber *value = (NSNumber *)obj;
                    switch (type) {
                            CASE_TYPE('c', char, charValue)
                            CASE_TYPE('C', unsigned char, unsignedCharValue)
                            CASE_TYPE('s', short, shortValue)
                            CASE_TYPE('S', unsigned short, unsignedShortValue)
                            CASE_TYPE('i', int, intValue)
                            CASE_TYPE('I', unsigned int, unsignedIntValue)
                            CASE_TYPE('l', long, longValue)
                            CASE_TYPE('L', unsigned long, unsignedLongValue)
                            CASE_TYPE('q', long long, longLongValue)
                            CASE_TYPE('Q', unsigned long long, unsignedLongLongValue)
                            CASE_TYPE('f', double, floatValue)
                            CASE_TYPE('d', double, doubleValue)
                            CASE_TYPE('B', BOOL, boolValue)
                        default:
                            break;
                    }
                }else if ([obj isKindOfClass:[NSString class]]){
                    NSString *value = (NSString *)obj;
                    switch (type) {
                            CASE_TYPE('c', const char *, UTF8String)
                            CASE_TYPE('C', const char *, UTF8String)
                            CASE_TYPE('s', short, intValue)
                            CASE_TYPE('S', unsigned short, intValue)
                            CASE_TYPE('i', int, intValue)
                            CASE_TYPE('I', unsigned int, intValue)
                            CASE_TYPE('l', long, longLongValue)
                            CASE_TYPE('L', unsigned long, longLongValue)
                            CASE_TYPE('q', long long, longLongValue)
                            CASE_TYPE('Q', unsigned long long, longLongValue)
                            CASE_TYPE('f', double, floatValue)
                            CASE_TYPE('d', double, doubleValue)
                            CASE_TYPE('B', BOOL, boolValue)
                        case '{':{
                            STRING_TYPE(CGRect, CGRectFromString(value))
                            STRING_TYPE(CGSize, CGSizeFromString(value))
                            STRING_TYPE(CGPoint, CGPointFromString(value))
                            STRING_TYPE(CGVector, CGVectorFromString(value))
                            STRING_TYPE(CGAffineTransform, CGAffineTransformFromString(value))
                        }
                        case '*':
                        case '^':{
                            STRING_TYPE(UIOffset, UIOffsetFromString(value))
                            STRING_TYPE(UIEdgeInsets, UIEdgeInsetsFromString(value))
                            STRING_TYPE(NSDirectionalEdgeInsets, NSDirectionalEdgeInsetsFromString(value))
                        }
                        case ':': {
                            STRING_TYPE(SEL, NSSelectorFromString(value))
                        }
                        default:
                            break;
                    }
                }else if ([obj isKindOfClass:[NSValue class]]){
                    NSValue *value = (NSValue *)obj;
                    switch (type) {
                        case '{':{
                            STRUCT_TYPE(CGRect, CGRectValue)
                            STRUCT_TYPE(CGSize, CGSizeValue)
                            STRUCT_TYPE(CGPoint, CGPointValue)
                            STRUCT_TYPE(CGVector, CGVectorValue)
                            STRUCT_TYPE(CGAffineTransform, CGAffineTransformValue)
                        }
                        case '*':
                        case '^':{
                            STRUCT_TYPE(UIOffset, UIOffsetValue)
                            STRUCT_TYPE(UIEdgeInsets, UIEdgeInsetsValue)
                            STRUCT_TYPE(NSDirectionalEdgeInsets, directionalEdgeInsetsValue)
                        }
                        default:
                            break;
                    }
                }else {
                    switch (type) {
                        case '#':{
                            [invocation setArgument:&obj atIndex:idx];
                            break;
                        }
                        default:
                            break;
                    }
                }
            }
        }
        
    }
    
    [invocation invoke];
    
    char returnType[255];
    strcpy(returnType, [methodSig methodReturnType]);
    
    if (strcmp(returnType, @encode(void)) == 0){
        return nil;
    }else if (strncmp(returnType, "@", 1) == 0) {
        void *result;
        [invocation getReturnValue:&result];
        return [self transferSelector:selector] ? (__bridge_transfer id)result : (__bridge id)result;
    }else{
        char type = returnType[0] == 'r' ? returnType[1] : returnType[0];
        switch (type) {
            case 'c':
            case 'C':
            case 's':
            case 'S':
            case 'i':
            case 'I':
            case 'l':
            case 'L':
            case 'q':
            case 'Q':
            case 'f':
            case 'd':
            case 'B':
            case '{':
            case '*':
            case '^': {
                char result;
                [invocation getReturnValue:&result];
                return @(result);
            }
            case '#': {
                Class result;
                [invocation getReturnValue:&result];
                return result;
            }
            default:{
                break;
            }
        }
    }
    
    return nil;
}

+ (BOOL)transferSelector:(SEL)selector{
    NSArray *retainSelectors = @[@"alloc",@"new",@"copy",@"mutableCopy"];
    return [retainSelectors containsObject:NSStringFromSelector(selector)];
}

#pragma mark - private methods
+ (void)noTarget:(NSString *)target action:(NSString *)action targetObject:(id)targetObject{
    if (targetObject) {
        if ([target hasSuffix:kNSObjectClassObjectName]) {
            target = [target stringByReplacingOccurrencesOfString:kNSObjectClassObjectName withString:@""];
            NSLog(@"%@", [NSString stringWithFormat:@"Method not found，请检查类<%@>中类方法<%@>是否存在",target,action]);
        }else{
            NSLog(@"%@", [NSString stringWithFormat:@"Method not found，请检查类<%@>中实例方法<%@>是否存在",target,action]);
        }
    }else{
        if ([target hasSuffix:kNSObjectClassObjectName]) {
            target = [target stringByReplacingOccurrencesOfString:kNSObjectClassObjectName withString:@""];
        }
        NSLog(@"%@", [NSString stringWithFormat:@"target not found，请检查类<%@>是否存在",target]);
    }
}
@end


@implementation NSString (Mediator)
- (NSString *)classString{
    return [self stringByAppendingString:kNSObjectClassObjectName];
}
@end

//
//  TPUserDefaults.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/11.
//

#import "TPUserDefaults.h"

@implementation TPUserDefaults

+ (BOOL)boolValueForKey:(NSString *)key{
    return [[self valueForKey:key] boolValue];
}

+ (void)setBoolValue:(BOOL)value forKey:(NSString *)key{
    [self setValue:@(value) forKey:key];
}

+ (nullable id)valueForKey:(NSString *)key{
    if (!key) return nil;
    return [NSUserDefaults.standardUserDefaults valueForKey:key];
}

+ (void)setValue:(nullable id)value forKey:(NSString *)key{
    if (!value || !key) return;
    [NSUserDefaults.standardUserDefaults setValue:value forKey:key];
    [NSUserDefaults.standardUserDefaults synchronize];
}

@end

//
//  TPUserDefaults.h
//  OCProject
//
//  Created by 王祥伟 on 2024/3/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPUserDefaults : NSObject

+ (BOOL)boolValueForKey:(NSString *)key;
+ (void)setBoolValue:(BOOL)value forKey:(NSString *)key;

+ (nullable id)valueForKey:(NSString *)key;
+ (void)setValue:(nullable id)value forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END

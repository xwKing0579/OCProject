//
//  TPSpamMethod.h
//  OCProject
//
//  Created by 王祥伟 on 2024/3/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXTERN NSString *const kSpamMethodPrefixName;

@interface TPSpamMethod : NSObject

+ (void)spamCodeProjectPath:(NSString *)projectPath;
+ (void)spamCodeProjectPath:(NSString *)projectPath ignoreDirNames:(NSArray<NSString *> * __nullable)ignoreDirNames;

@end

NS_ASSUME_NONNULL_END

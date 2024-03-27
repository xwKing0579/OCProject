//
//  TPSpamMethod.h
//  OCProject
//
//  Created by 王祥伟 on 2024/3/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPSpamMethod : NSObject

+ (void)spamCodeProjectPath:(NSString *)projectPath;
+ (void)spamCodeProjectPath:(NSString *)projectPath ignoreDirNames:(NSArray<NSString *> * __nullable)ignoreDirNames;

+ (void)getWordsProjectPath:(NSString *)projectPath ignoreDirNames:(NSArray<NSString *> * __nullable)ignoreDirNames;

+ (NSSet *)combinedWords:(NSArray *)words minLen:(int)minLen maxLen:(int)maxLen count:(int)count;

@end



NS_ASSUME_NONNULL_END

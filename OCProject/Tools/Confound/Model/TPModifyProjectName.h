//
//  TPModifyProjectName.h
//  OCProject
//
//  Created by 王祥伟 on 2024/3/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPModifyProjectName : NSObject

+ (void)modifyProjectName:(NSString *)projectPath oldName:(NSString *)oldName newName:(NSString *)newName;

+ (void)modifyFilePrefix:(NSString *)projectPath oldPrefix:(NSString *)oldPrefix newPrefix:(NSString *)newPrefix;

@end

NS_ASSUME_NONNULL_END

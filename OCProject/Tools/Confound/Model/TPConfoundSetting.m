//
//  TPConfoundSetting.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/25.
//

#import "TPConfoundSetting.h"

@implementation TPConfoundSetting

+ (instancetype)sharedManager {
    static TPConfoundSetting *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
        manager.spamSet = [TPSpamCodeSetting new];
        manager.spamSet.isSpamInNewDir = YES;
        manager.spamSet.isSpamInOldCode = YES;
        manager.spamSet.isSpamMethodPrefix = YES;
        manager.spamSet.spamFileSet = [TPSpamCodeFileSetting new];
        manager.spamSet.spamFileSet.spamFileNum = 100;
    });
    return manager;
}

- (BOOL)isSpam{
    return self.spamSet.isSpamInOldCode || self.spamSet.isSpamInNewDir;
}

@end


@implementation TPSpamCodeSetting

- (NSString *)spamMethodPrefix{
    return _spamMethodPrefix ?: [NSString stringWithFormat:@"%@_",[TPString.prefix_app lowercaseString]];
}

@end

@implementation TPSpamCodeFileSetting

- (NSString *)projectName{
    return _projectName ?: @"ProjectName";
}

- (NSString *)dirName{
    return _dirName ?: @"SpamCode";
}

- (NSString *)author{
    return _author ?: @"author";
}

- (NSString *)spamClassPrefix{
    return _spamClassPrefix ?: TPString.prefix_app;
}

- (NSString *)spamhFileContent{
    return [NSString stringWithFormat:@"//\n//  file.h\n//  %@\n//\n//  Created by %@ on date.\n//\n\n#import <UIKit/UIKit.h>\n\nNS_ASSUME_NONNULL_BEGIN\n\n@interface file : UIView\n\n@end\n\nNS_ASSUME_NONNULL_END\n",self.projectName,self.author];
}

- (NSString *)spammFileContent{
    return [NSString stringWithFormat:@"//\n//  file.m\n//  %@\n//\n//  Created by %@ on date.\n//\n\n#import \"file.h\"\n\n@implementation file\n\n@end",self.projectName,self.author];
}

@end


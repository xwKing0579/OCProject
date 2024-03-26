//
//  TPConfoundSetting.h
//  OCProject
//
//  Created by 王祥伟 on 2024/3/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class TPSpamCodeSetting,TPSpamCodeFileSetting;

@interface TPConfoundSetting : NSObject
+ (instancetype)sharedManager;
@property (nonatomic, assign) BOOL isSpam;
@property (nonatomic, strong) TPSpamCodeSetting *spamSet;
@end

@interface TPSpamCodeSetting : NSObject
@property (nonatomic, assign) BOOL isSpamInOldCode;
@property (nonatomic, assign) BOOL isSpamInNewDir;
@property (nonatomic, assign) BOOL isSpamMethodPrefix;
@property (nonatomic, assign) int spamMethodNum;
@property (nonatomic, copy) NSString *spamMethodPrefix;
@property (nonatomic, strong) TPSpamCodeFileSetting *spamFileSet;
@end

@interface TPSpamCodeFileSetting : NSObject
@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *dirName;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *spamClassPrefix;
@property (nonatomic, copy) NSString *spamhFileContent;
@property (nonatomic, copy) NSString *spammFileContent;
@property (nonatomic, assign) int spamFileNum;
@end

NS_ASSUME_NONNULL_END

//
//  TPConfoundSetting.h
//  OCProject
//
//  Created by 王祥伟 on 2024/3/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class TPSpamCodeSetting,TPSpamCodeFileSetting,TPSpamCodeWordSetting,TPModifyProjectSetting;

@interface TPConfoundSetting : NSObject

@property (nonatomic, assign) BOOL isSpam;
@property (nonatomic, assign) BOOL isModify;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, strong) TPSpamCodeSetting *spamSet;
@property (nonatomic, strong) TPModifyProjectSetting *modifySet;
+ (instancetype)sharedManager;
@end

@interface TPSpamCodeSetting : NSObject
@property (nonatomic, assign) BOOL isSpamInOldCode;
@property (nonatomic, assign) BOOL isSpamInNewDir;
@property (nonatomic, assign) BOOL isSpamMethod;
@property (nonatomic, assign) BOOL isSpamOldWords;
@property (nonatomic, assign) int spamMethodNum;
@property (nonatomic, copy) NSString *spamMethodPrefix;
@property (nonatomic, strong) TPSpamCodeFileSetting *spamFileSet;
@property (nonatomic, strong) NSMutableDictionary *projectWords;
@property (nonatomic, copy) NSArray *combinedWords;
@property (nonatomic, strong) TPSpamCodeWordSetting *spamWordSet;
@end

@interface TPSpamCodeFileSetting : NSObject
@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *dirName;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *spamClassPrefix;
@property (nonatomic, copy) NSString *spamhFileContent;
@property (nonatomic, copy) NSString *spammFileContent;
@property (nonatomic, copy) NSString *spamFileDesContent;
@property (nonatomic, assign) int spamFileNum;

@end

@interface TPSpamCodeWordSetting : NSObject
@property (nonatomic, assign) int minLength;
@property (nonatomic, assign) int maxLength;
@property (nonatomic, assign) int frequency;
@property (nonatomic, copy) NSArray *blackList;
@end

@interface TPModifyProjectSetting : NSObject
@property (nonatomic, copy) NSString *oldName;
@property (nonatomic, copy) NSString *modifyName;
@property (nonatomic, copy) NSString *oldPrefix;
@property (nonatomic, copy) NSString *modifyPrefix;
@end

NS_ASSUME_NONNULL_END

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
        manager.spamSet.isSpamMethod = YES;
        manager.spamSet.isSpamOldWords = YES;
        manager.spamSet.projectWords = [NSMutableDictionary dictionary];
        manager.spamSet.spamFileSet = [TPSpamCodeFileSetting new];
        manager.spamSet.spamFileSet.spamFileNum = 100;
        manager.spamSet.spamWordSet = [TPSpamCodeWordSetting new];
        manager.spamSet.spamWordSet.minLength = 3;
        manager.spamSet.spamWordSet.maxLength = 10;
        manager.spamSet.spamWordSet.frequency = 10;
    });
    return manager;
}

- (BOOL)isSpam{
    return self.spamSet.isSpamInOldCode || self.spamSet.isSpamInNewDir;
}

@end


@implementation TPSpamCodeSetting

- (NSString *)spamMethodPrefix{
    return self.isSpamMethod ? safeString(_spamMethodPrefix) : @"";
}

- (NSArray *)combinedWords{
    NSArray *words = self.projectWords.allKeys;
    TPSpamCodeWordSetting *set = self.spamWordSet;
    NSMutableArray *result = [NSMutableArray array];
    for (NSString *word in words) {
        if (word.length < set.minLength) continue;
        if (word.length > set.maxLength) continue;
        if ([set.blackList containsObject:word]) continue;
        if ([self.projectWords[word] intValue] < set.frequency) continue;
        [result addObject:word];
    }
    
    NSArray *addArr = @[@"mark",@"switch",@"for",@"nteger",@"string",@"static",@"cgrect",@"rect",@"array",@"image",@"label",@"integer",@"created",@"height",@"view",@"index",@"all",@"and",@"basic",@"copy",@"right",@"the",@"float",@"error",@"data",@"const",@"lazy",@"date",@"result",@"button",@"int",@"rights",@"weak",@"strong",@"value",@"width",@"bool",@"urlString",@"methods",@"matches",@"manager",@"object",@"plugin",@"source",@"time",@"item",@"selected",@"except",@"param",@"name",@"path",@"token",@"navigation",@"configure",@"file",@"count"];
    while (result.count < addArr.count) {
        NSString *string = addArr[arc4random()%addArr.count];
        if (![result containsObject:string]) [result addObject:string];
    }
    return result;
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

- (NSString *)spamFileDesContent{
    return [NSString stringWithFormat:@"//\n//  file.m\n//  %@\n//\n//  Created by %@ on date.\n//\n\n#import <Foundation/Foundation.h>\n\n",self.projectName,self.author];
}

@end

@implementation TPSpamCodeWordSetting

- (NSArray *)blackList{
    return _blackList ?: @[@"void",@"init",@"else",@"if",@"interface",@"implementation"];
}

@end

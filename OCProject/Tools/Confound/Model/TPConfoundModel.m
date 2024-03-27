//
//  TPConfoundModel.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/22.
//

#import "TPConfoundModel.h"

@implementation TPConfoundModel

+ (NSArray *)data_file{
    TPSpamCodeFileSetting *fileSet = TPConfoundSetting.sharedManager.spamSet.spamFileSet;
    NSString *spamFileNum = [NSString stringWithFormat:@"%d",fileSet.spamFileNum];
    NSArray *data = @[@{@"idStr":@"121",@"title":@"项目名",@"content":fileSet.projectName},
                      @{@"idStr":@"122",@"title":@"作者",@"content":fileSet.author},
                      @{@"idStr":@"123",@"title":@"数量",@"content":spamFileNum},
                      @{@"idStr":@"124",@"title":@"类名前缀",@"content":fileSet.spamClassPrefix}];
    return [NSArray yy_modelArrayWithClass:[TPConfoundModel class] json:data];
}

+ (NSArray *)data_code{
    TPSpamCodeSetting *setting = TPConfoundSetting.sharedManager.spamSet;
    NSArray *data = @[@{@"idStr":@"11",@"title":@"在原文件中添加垃圾方法",@"setting":@0,@"selecte":@(setting.isSpamInOldCode)},
                      @{@"idStr":@"12",@"title":@"新建.h、.m文件并添加垃圾方法",@"setting":@1,@"selecte":@(setting.isSpamInNewDir),@"url":TPString.vc_spam_code_model},
                      @{@"idStr":@"13",@"title":@"方法名配置",@"setting":@1,@"selecte":@1,@"url":TPString.vc_spam_code_method},
                      @{@"idStr":@"14",@"title":@"使用项目单词命名类|方法名",@"setting":@1,@"selecte":@1,@"url":TPString.vc_spam_code_word}];
    return [NSArray yy_modelArrayWithClass:[TPConfoundModel class] json:data];
}

+ (NSArray *)data_code_method{
    TPSpamCodeSetting *codeSet = TPConfoundSetting.sharedManager.spamSet;
    NSArray *data = @[@{@"idStr":@"131",@"title":@"方法名前缀",@"content":codeSet.spamMethodPrefix ?: @""},
    ];
    return [NSArray yy_modelArrayWithClass:[TPConfoundModel class] json:data];
}

+ (NSArray *)data_code_word{
    TPSpamCodeSetting *set = TPConfoundSetting.sharedManager.spamSet;
    TPSpamCodeWordSetting *wordSet = set.spamWordSet;
    NSArray *data = @[@{@"idStr":@"141",@"title":@"出现频率大于",@"content":[NSString stringWithFormat:@"%u",wordSet.frequency]},
                      @{@"idStr":@"142",@"title":@"单词最小长度",@"content":[NSString stringWithFormat:@"%u",wordSet.minLength]},
                      @{@"idStr":@"143",@"title":@"单词最大长度",@"content":[NSString stringWithFormat:@"%u",wordSet.maxLength]},
                      @{@"idStr":@"144",@"title":@"单词黑名单",@"content":[wordSet.blackList componentsJoinedByString:@","]},
                      @{@"idStr":@"145",@"title":@"筛选结果",@"content":[set.combinedWords componentsJoinedByString:@","]},
    ];
    return [NSArray yy_modelArrayWithClass:[TPConfoundModel class] json:data];
}

@end

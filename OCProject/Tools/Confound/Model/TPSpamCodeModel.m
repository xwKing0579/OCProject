//
//  TPSpamCodeModel.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/25.
//

#import "TPSpamCodeModel.h"

@implementation TPSpamCodeModel

+ (NSArray *)data_file{
    TPSpamCodeFileSetting *fileSet = TPConfoundSetting.sharedManager.spamSet.spamFileSet;
    NSString *spamFileNum = [NSString stringWithFormat:@"%d",fileSet.spamFileNum];
    NSArray *data = @[@{@"idStr":@"31",@"title":@"项目名",@"content":fileSet.projectName},
                      @{@"idStr":@"32",@"title":@"作者",@"content":fileSet.author},
                      @{@"idStr":@"33",@"title":@"数量",@"content":spamFileNum},
                      @{@"idStr":@"34",@"title":@"类名前缀",@"content":fileSet.spamClassPrefix}];
    return [NSArray yy_modelArrayWithClass:[TPSpamCodeModel class] json:data];
}

+ (NSArray *)data_code{
    TPSpamCodeSetting *setting = TPConfoundSetting.sharedManager.spamSet;
    NSArray *data = @[@{@"idStr":@"21",@"title":@"在原文件中添加垃圾方法",@"setting":@0,@"selecte":@(setting.isSpamInOldCode)},
                      @{@"idStr":@"22",@"title":@"新建.h、.m文件并添加垃圾方法",@"setting":@1,@"selecte":@(setting.isSpamInNewDir),@"url":TPString.vc_spam_code_model},
                      @{@"idStr":@"23",@"title":@"方法添加前缀",@"setting":@1,@"selecte":@1,@"url":TPString.vc_spam_code_prefix}];
    return [NSArray yy_modelArrayWithClass:[TPConfoundModel class] json:data];
}

+ (NSArray *)data_prefix{
    TPSpamCodeSetting *codeSet = TPConfoundSetting.sharedManager.spamSet;
    NSArray *data = @[@{@"idStr":@"24",@"title":@"方法名前缀",@"content":codeSet.spamMethodPrefix ?: @""}];
    return [NSArray yy_modelArrayWithClass:[TPSpamCodeModel class] json:data];
}

@end

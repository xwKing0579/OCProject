//
//  TPConfoundModel.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/22.
//

#import "TPConfoundModel.h"

@implementation TPConfoundModel

+ (NSArray *)data{
    TPConfoundSetting *set = TPConfoundSetting.sharedManager;
    NSArray *data = @[
    @{@"idStr":@"1",@"title":@"添加垃圾代码",@"setting":@1,@"selecte":@(set.isSpam),@"url":TPString.vc_spam_code},
    @{@"idStr":@"2",@"title":@"修改工程名(`Podfile`被修改后需要`pod install`)",@"setting":@1,@"selecte":@(set.isModifyProject),@"url":TPString.vc_modify_project},
    @{@"idStr":@"3",@"title":@"修改文件名前缀(包含类名之外)",@"setting":@1,@"selecte":@(set.isSpam),@"url":TPString.vc_modify_class},
    @{@"idStr":@"4",@"title":@"删除注释",@"setting":@0,@"selecte":@(set.isClearComment)}];
    return [NSArray yy_modelArrayWithClass:[TPConfoundModel class] json:data];
}

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
    TPConfoundSetting *set = TPConfoundSetting.sharedManager;
    TPSpamCodeSetting *codeSet = set.spamSet;
    TPSpamCodeFileSetting *fileSet = codeSet.spamFileSet;
    NSString *spamCodeDirName = @"新建.h、.m文件并添加垃圾方法";
    if (fileSet.dirName.length){
        spamCodeDirName = [NSString stringWithFormat:@"新建.h、.m文件并添加垃圾方法(生成的文件存放在%@目录下,需要手动拖拽到项目中)",[set.path stringByAppendingPathComponent:fileSet.dirName]];
    }
    NSArray *data = @[@{@"idStr":@"11",@"title":@"在原文件中添加垃圾方法",@"setting":@0,@"selecte":@(codeSet.isSpamInOldCode)},
                      @{@"idStr":@"12",@"title":spamCodeDirName,@"setting":@1,@"selecte":@(codeSet.isSpamInNewDir),@"url":TPString.vc_spam_code_model},
                      @{@"idStr":@"13",@"title":@"新增方法名配置",@"setting":@1,@"selecte":@(codeSet.isSpamMethod),@"url":TPString.vc_spam_code_method},
                      @{@"idStr":@"14",@"title":@"取项目中单词来命名'类名|方法名'",@"setting":@1,@"selecte":@(codeSet.isSpamOldWords),@"url":TPString.vc_spam_code_word}];
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

+ (NSArray *)data_modify_project{
    TPModifyProjectSetting *modifySet = TPConfoundSetting.sharedManager.modifySet;
    NSArray *data = @[@{@"idStr":@"21",@"title":@"旧项目名",@"content":safeString(modifySet.oldName)},
                      @{@"idStr":@"22",@"title":@"新项目名",@"content":safeString(modifySet.modifyName)}];
    return [NSArray yy_modelArrayWithClass:[TPConfoundModel class] json:data];
}

+ (NSArray *)data_modify_class{
    TPModifyProjectSetting *modifySet = TPConfoundSetting.sharedManager.modifySet;
    NSArray *data = @[
    @{@"idStr":@"30",@"title":@"替换其他命名前缀(类名之外相同前缀code)",@"setting":@0,@"selecte":@(modifySet.isModifyPrefixOther)},
                      @{@"idStr":@"31",@"title":@"旧类名前缀",@"content":safeString(modifySet.oldPrefix)},
                      @{@"idStr":@"32",@"title":@"新类名前缀",@"content":safeString(modifySet.modifyPrefix)}];
    return [NSArray yy_modelArrayWithClass:[TPConfoundModel class] json:data];
}

+ (void)editContent:(id)content idStr:(NSString *)idStr{
    TPConfoundSetting *set = TPConfoundSetting.sharedManager;
    TPSpamCodeSetting *codeSet = set.spamSet;
    TPSpamCodeFileSetting *fileSet = codeSet.spamFileSet;
    TPSpamCodeWordSetting *wordSet = codeSet.spamWordSet;
    TPModifyProjectSetting *modify = set.modifySet;
    
    NSString *text;
    BOOL selected = NO;
    if ([content isKindOfClass:[NSString class]]){
        text = content;
    }else if ([content isKindOfClass:[NSNumber class]]){
        selected = [(NSNumber *)content intValue];
    }
    
    switch (idStr.intValue) {
        case 1:
            set.isSpam = selected;
            break;
        case 2:
            set.isModifyProject = selected;
            break;
        case 3:
            set.isModifyClass = selected;
            break;
        case 4:
            set.isClearComment = selected;
            break;
        case 11:
            codeSet.isSpamInOldCode = selected;
            break;
        case 12:
            codeSet.isSpamInNewDir = selected;
            break;
        case 13:
            codeSet.isSpamMethod = selected;
            break;
        case 14:
            codeSet.isSpamOldWords = selected;
            break;
        case 121:
            fileSet.projectName = text;
            break;
        case 122:
            fileSet.author = text;
            break;
        case 123:
            fileSet.spamFileNum = text.intValue;
            break;
        case 124:
            fileSet.spamClassPrefix = text;
            break;
        case 131:
            codeSet.spamMethodPrefix = text;
            break;
        case 141:
            wordSet.frequency = text.intValue;
            break;
        case 142:
            wordSet.minLength = text.intValue;
            break;
        case 143:
            wordSet.maxLength = text.intValue;
            break;
        case 144:
            wordSet.blackList = [text componentsSeparatedByString:@","];
            break;
        case 21:
            modify.oldName = text;
            break;
        case 22:
            modify.modifyName = text;
            break;
        case 30:
            modify.isModifyPrefixOther = selected;
        case 31:
            modify.oldPrefix = text;
            break;
        case 32:
            modify.modifyPrefix = text;
            break;
        default:
            break;
    }
}
@end

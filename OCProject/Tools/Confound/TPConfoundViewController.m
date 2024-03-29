//
//  TPConfoundViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/22.
//

#import "TPConfoundViewController.h"
#import "TPConfoundModel.h"
#import "TPSpamMethod.h"
#import "TPModifyProject.h"
@interface TPConfoundViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *textView;
@end

@implementation TPConfoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"马甲包工具";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"开始" style:(UIBarButtonItemStyleDone) target:self action:@selector(startConfoundAction)];
    TPConfoundSetting.sharedManager.path = @"/Users/wangxiangwei/Desktop/QuShou";
    self.data = [TPConfoundModel data];
    [self.tableView reloadData];
}

- (void)startConfoundAction{
    TPConfoundSetting *set = TPConfoundSetting.sharedManager;
    TPSpamCodeSetting *codeSet = set.spamSet;
    TPSpamCodeFileSetting *fileSet = codeSet.spamFileSet;
    TPModifyProjectSetting *modifySet = set.modifySet;
    
    modifySet.oldPrefix = @"TP";
    modifySet.modifyPrefix = @"QS";
    
    NSString *path = set.path;
    if (!path.length) {
        [TPToastManager showText:@"请输入绝对路径"];
        return;
    }
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]){
        [TPToastManager showText:@"路径不对，没找到文件"];
        return;
    }
    
    if (set.isModifyProject && (!modifySet.oldName.length || !modifySet.modifyName.length)){
        [TPToastManager showText:@"请填写修改项目名称的内容"];
        return;
    }
    
    if (set.isModifyClass && (!modifySet.oldPrefix.length || !modifySet.modifyPrefix.length)){
        [TPToastManager showText:@"请填写修改类名称前缀的内容"];
        return;
    }
    [TPToastManager showLoading];
    
    NSArray *ignoreDirNames = @[@"Pods"];
    ///垃圾代码
    if (set.isSpam) {
        if (codeSet.isSpamOldWords){
            [TPSpamMethod getWordsProjectPath:path ignoreDirNames:ignoreDirNames];
        }
        NSString *dirPath;
        if (set.spamSet.isSpamInNewDir){
            dirPath = [path stringByAppendingPathComponent:set.spamSet.spamFileSet.dirName];
            if (![fm fileExistsAtPath:dirPath]){
                NSError *error = nil;
                [fm createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
                if (error){
                    [TPToastManager showText:@"创建文件夹失败"];
                    [TPToastManager hideLoading];
                    return;
                }
            }
            
            NSSet *result = [TPSpamMethod combinedWords:codeSet.combinedWords minLen:2 maxLen:3 count:fileSet.spamFileNum];
            NSString *importFile = @"";
            for (NSString *name in result.allObjects) {
                NSArray *classArr = @[@"NSObject",@"UIView",@"UIViewController",@"UIButton",@"UILabel",@"UITextView",@"UITextField",@"UIImageView"];
                NSString *classString = classArr[arc4random()%classArr.count];
                NSString *className = [classString stringByReplacingOccurrencesOfString:@"UI" withString:@""];
                if ([classString isEqualToString:@"NSObject"]){
                    className = @"Model";
                }
                
                NSString *nameString = [name stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[name substringToIndex:1] uppercaseString]];
                NSString *fileName = [NSString stringWithFormat:@"%@%@%@",codeSet.isSpamMethod ? safeString(fileSet.spamClassPrefix) : @"",nameString,className];
                importFile = [importFile stringByAppendingString:[NSString stringWithFormat:@"#import \"%@.h\"\n",fileName]];
                NSString *filePathHead = [dirPath stringByAppendingPathComponent:fileName];
                NSArray *files = @[[filePathHead stringByAppendingString:@".h"],[filePathHead stringByAppendingString:@".m"]];
                
                for (NSString *filePath in files) {
                    if ([fm fileExistsAtPath:filePath]){
                        continue;
                    }
                    NSString *string = fileSet.spammFileContent;
                    if ([filePath hasSuffix:@".h"]){
                        string =  fileSet.spamhFileContent;
                        string = [string stringByReplacingOccurrencesOfString:@"UIView" withString:classString];
                        if ([classString isEqualToString:@"NSObject"]){
                            string = [string stringByReplacingOccurrencesOfString:@"UIKit/UIKit" withString:@"Foundation/Foundation"];
                        }
                    }
                    string = [string stringByReplacingOccurrencesOfString:@"file" withString:fileName];
                    string = [string stringByReplacingOccurrencesOfString:@"date" withString:[NSDate currentTimeFormatterString:@"yyyy/MM/dd"]];
                    [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                }
            }
            NSString *importPath = [dirPath stringByAppendingPathComponent:fileSet.dirName];
            importPath = [importPath stringByAppendingString:@".h"];
            if ([fm fileExistsAtPath:importPath]){
                NSError *error = nil;
                NSMutableString *content = [NSMutableString stringWithContentsOfFile:importPath encoding:NSUTF8StringEncoding error:&error];
                importFile = [content stringByAppendingString:importFile];
            }else{
                importFile = [fileSet.spamFileDesContent stringByAppendingString:importFile];
            }
            [importFile writeToFile:importPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
        
        NSString *projectPath = codeSet.isSpamInOldCode ? path : dirPath;
        [TPSpamMethod spamCodeProjectPath:projectPath ignoreDirNames:ignoreDirNames];
    }
    
    //修改项目名称
    if (set.isModifyProject){
        [TPModifyProject modifyProjectName:path oldName:modifySet.oldName newName:modifySet.modifyName];
    }
    
    ///修改文件前缀
    if (set.isModifyClass){
        [TPModifyProject modifyFilePrefix:path otherPrefix:modifySet.isModifyPrefixOther oldPrefix:modifySet.oldPrefix newPrefix:modifySet.modifyPrefix];
    }
    
    //删除注释
    if (set.isClearComment){
        [TPModifyProject clearCodeComment:path ignoreDirNames:ignoreDirNames];
    }
    
    [TPToastManager hideLoading];
}

- (NSString *)cellClass{
    return TPString.tc_confound;
}

#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    NSString *path = textView.text.whitespace;
    
    TPConfoundSetting *set = TPConfoundSetting.sharedManager;
    set.path = path;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TPConfoundModel *model = self.data[indexPath.row];
    [TPRouter jumpUrl:model.url];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIDevice.width, 80)];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.font = UIFont.font14;
    textView.textColor = UIColor.c000000;
    textView.layer.masksToBounds = YES;
    textView.layer.borderColor = UIColor.cbfbfbf.CGColor;
    textView.layer.borderWidth = 0.5;
    textView.placeholder = @"输入文件夹绝对路径";
    textView.contentInset = UIEdgeInsetsMake(15, 15, 15, 15);
    textView.delegate = self;
    textView.text = TPConfoundSetting.sharedManager.path;
    [view addSubview:textView];
    self.textView = textView;
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}

@end

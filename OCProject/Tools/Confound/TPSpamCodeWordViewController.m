//
//  TPSpamCodeWordViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/27.
//

#import "TPSpamCodeWordViewController.h"
#import "TPConfoundModel.h"
#import "TPSpamMethod.h"
@interface TPSpamCodeWordViewController ()

@end

@implementation TPSpamCodeWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"检测所有符合条件单词";
    self.data = [TPConfoundModel data_code_word];
    [self.tableView reloadData];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:(UIBarButtonItemStyleDone) target:self action:@selector(clickFilterWordsAction)];
}

- (void)clickFilterWordsAction{
    [TPToastManager showLoading];
    
    TPConfoundSetting *set = TPConfoundSetting.sharedManager;
    if (set.path){
        [TPSpamMethod getWordsProjectPath:set.path ignoreDirNames:@[@"Pods"]];
        self.data = [TPConfoundModel data_code_word];
        [self.tableView reloadData];
        [TPToastManager hideLoading];
    }else{
        [TPToastManager showText:@"先设置项目绝对路径"];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellString = indexPath.row == self.data.count - 1 ? TPString.tc_confound_label : TPString.tc_spam_code_model;
    return [NSObject performTarget:cellString.classString action:[self actionString] object:tableView object:self.data[indexPath.row]] ?: [UITableViewCell new];
}

@end

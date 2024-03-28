//
//  TPModifyProjectViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/28.
//

#import "TPModifyProjectViewController.h"
#import "TPConfoundModel.h"
@interface TPModifyProjectViewController ()

@end

@implementation TPModifyProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改项目名称";
    self.data = [TPConfoundModel data_modify_project];
    [self.tableView reloadData];
}

- (NSString *)cellClass{
    return TPString.tc_spam_code_model;
}

@end

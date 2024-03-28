//
//  TPSpamCodeMethodViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/27.
//

#import "TPSpamCodeMethodViewController.h"
#import "TPConfoundModel.h"
@interface TPSpamCodeMethodViewController ()

@end

@implementation TPSpamCodeMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新增方法名前缀";
    self.data = [TPConfoundModel data_code_method];
    [self.tableView reloadData];
}

- (NSString *)cellClass{
    return TPString.tc_spam_code_model;
}


@end

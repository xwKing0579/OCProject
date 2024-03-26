//
//  TPSpamCodePrefixViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/26.
//

#import "TPSpamCodePrefixViewController.h"
#import "TPSpamCodeModel.h"
#import "TPSpamCodeModelTableViewCell.h"
@interface TPSpamCodePrefixViewController ()

@end

@implementation TPSpamCodePrefixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"方法/类前缀";
    self.data = [TPSpamCodeModel data_prefix];
    [self.tableView reloadData];
}

- (NSString *)cellClass{
    return TPString.tc_spam_code_model;
}

@end

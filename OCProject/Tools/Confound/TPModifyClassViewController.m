//
//  TPModifyClassViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/28.
//

#import "TPModifyClassViewController.h"
#import "TPConfoundModel.h"
#import "TPModifyProject.h"
@interface TPModifyClassViewController ()

@end

@implementation TPModifyClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改类名前缀(大写)";
    self.data = [TPConfoundModel data_modify_class];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellString = indexPath.row == 0 ? TPString.tc_confound : TPString.tc_spam_code_model;
    return [NSObject performTarget:cellString.classString action:[self actionString] object:tableView object:self.data[indexPath.row]] ?: [UITableViewCell new];
}
@end

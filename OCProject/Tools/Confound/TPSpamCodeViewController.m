//
//  TPSpamCodeViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/22.
//

#import "TPSpamCodeViewController.h"
#import "TPSpamCodeModel.h"

@interface TPSpamCodeViewController ()

@end

@implementation TPSpamCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"垃圾代码配置";
    self.data = [TPSpamCodeModel data_code];
    [self.tableView reloadData];
}

- (NSString *)cellClass{
    return TPString.tc_confound;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TPConfoundModel *model = self.data[indexPath.row];
    [TPRouter jumpUrl:model.url];
}

@end

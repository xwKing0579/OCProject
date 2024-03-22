//
//  TPConfoundViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/22.
//

#import "TPConfoundViewController.h"
#import "TPConfoundModel.h"
@interface TPConfoundViewController ()

@end

@implementation TPConfoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.data = [self data];
    [self.tableView reloadData];
}

- (NSArray *)data{
    NSArray *data = @[@{@"title":@"添加垃圾代码",@"setting":@1,@"selecte":@0,@"url":TPString.vc_spam_code}];
    return [NSArray yy_modelArrayWithClass:[TPConfoundModel class] json:data];
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

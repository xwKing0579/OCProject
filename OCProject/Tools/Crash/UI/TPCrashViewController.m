//
//  TPCrashViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/13.
//

#import "TPCrashViewController.h"
#import "TPCrashManager.h"
@interface TPCrashViewController ()
@end

@implementation TPCrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"崩溃信息(%@)",[TPCrashManager isOn] ? @"开" : @"关"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"delete"].original style:(UIBarButtonItemStyleDone) target:self action:@selector(removeCrashData)];
    self.data = ((NSArray *)[TPCrashCache crashData]).reverseObjectEnumerator.allObjects;
    [self.tableView reloadData];
}

- (void)removeCrashData{
    [TPCrashCache removeCrashData];
    self.data = @[];
    [self.tableView reloadData];
}

- (NSString *)cellClass{
    return TPString.tc_crash;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [TPRouter jumpUrl:TPString.vc_po_object params:@{@"object":self.data[indexPath.row]}];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath*)indexPath{
    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSMutableArray *data = [NSMutableArray arrayWithArray:self.data];
        [data removeObjectAtIndex:indexPath.row];
        [TPCrashCache cacheCrashData:data];
        self.data = data;
        [self.tableView reloadData];
    }];
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
    return config;
}

@end

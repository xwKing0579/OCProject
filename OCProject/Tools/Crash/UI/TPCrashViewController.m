//
//  TPCrashViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/13.
//

#import "TPCrashViewController.h"
#import "TPCrashCache.h"
#import "TPCrashModel.h"
@interface TPCrashViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <TPCrashModel *>*data;
@end

@implementation TPCrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"崩溃信息";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"delete"] style:(UIBarButtonItemStyleDone) target:self action:@selector(removeCrashData)];
    self.data = [TPCrashCache crashData];
    [self.tableView reloadData];
}

- (void)removeCrashData{
    [TPCrashCache removeCrashData];
    self.data = @[];
    [self.tableView reloadData];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TPCrashModel *model = self.data[indexPath.row];
    return [TPMediator performTarget:@"TPCrashTableViewCell_Class" action:@"initWithTableView:withModel:" object:tableView object:model] ?: [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [TPRouter jumpUrl:@"native/TPCrashDetailViewController" params:@{@"model":self.data[indexPath.row]}];
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

#pragma mark -- setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0.01)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0.01)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}
@end

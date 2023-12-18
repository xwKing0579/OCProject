//
//  TPFileDataViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/15.
//

#import "TPFileDataViewController.h"

@interface TPFileDataViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TPFileDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.fileName;
    
    [self.tableView reloadData];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dic.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TPMediator performTarget:@"TPFileDataTableViewCell_Class" action:@"initWithTableView:withKey:withValue:" objects:@{@"object1":tableView,@"object2":self.dic.allKeys[indexPath.row],@"object3":self.dic[self.dic.allKeys[indexPath.row]]}] ?: [UITableViewCell new];
}

#pragma mark -- setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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

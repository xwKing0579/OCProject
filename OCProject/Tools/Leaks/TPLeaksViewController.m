//
//  TPLeaksViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/22.
//

#import "TPLeaksViewController.h"
#import "MLeaksMessenger.h"
@interface TPLeaksViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *data;
@end

@implementation TPLeaksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"内存泄漏";
    
    NSMutableArray *data = [NSMutableArray array];
    for (NSNumber *num in [MLeaksMessenger leaks]) {
        NSString *ptr = [[NSString alloc] initWithFormat:@"%llx",num.unsignedLongLongValue];
        ptr = [ptr hasPrefix:@"0x"] ? ptr : [@"0x" stringByAppendingString:ptr];
        uintptr_t hex = strtoull(ptr.UTF8String, NULL, 0);
        id obj = (__bridge id)(void *)hex;
        if (obj) [data addObject:obj];
    }
    self.data = data;
    [self.tableView reloadData];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TPMediator performTarget:@"TPLeaksTableViewCell_Class" action:@"initWithTableView:withObject:" object:tableView object:self.data[indexPath.row]] ?: [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [TPMediator performTarget:TPRouter.routerClass action:TPRouter.routerJumpUrlParams object:@"TPLeakObjectViewController" object:@{@"object":self.data[indexPath.row]}];
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

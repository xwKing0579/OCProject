//
//  TPAppDetailViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/22.
//

#import "TPAppDetailViewController.h"

@interface TPAppDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *data;
@end

@implementation TPAppDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"app信息详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"openUrl" style:(UIBarButtonItemStyleDone) target:self action:@selector(openURL)];
    
    NSMutableArray *data = [NSMutableArray array];
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(self.model.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        id value = [self.model valueForKey:key];
        if (value) [data addObject:@{key:value}];
    }
    free(properties);
    
    self.data = data;
    [self.tableView reloadData];
}

- (void)openURL{
#ifdef DEBUG
    NSObject *workspace = [TPMediator performTarget:@"LSApplicationWorkspace_Class" action:@"defaultWorkspace"];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [workspace performSelector:NSSelectorFromString(@"openApplicationWithBundleID:") withObject:self.model.bundleIdentifier];
#pragma clang diagnostic pop
#endif
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TPMediator performTarget:@"TPCrashDetailTableViewCell_Class" action:@"initWithTableView:withDic:" object:tableView object:self.data[indexPath.row]] ?: [UITableViewCell new];
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

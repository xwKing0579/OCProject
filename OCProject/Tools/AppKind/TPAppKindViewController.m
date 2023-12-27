//
//  TPAppKindViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/22.
//

#import "TPAppKindViewController.h"
#import "TPAppKindModel.h"

@interface TPAppKindViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <TPAppKindModel *>*data;
@property (nonatomic, strong) NSArray <TPAppKindModel *>*result;
@end

@implementation TPAppKindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"手机安装APP";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"sort" style:(UIBarButtonItemStyleDone) target:self action:@selector(sortUserData)];
    
    [NSObject performTarget:@"MBProgressHUD_Class" action:@"showText:" object:@"数据加载中..."];
    
#ifdef DEBUG
    [TPAppKindModel sysetmAppList:^(NSArray<TPAppKindModel *> * _Nonnull appList) {
        self.data = appList;
        self.result = appList;
        [self.tableView reloadData];
    }];
#endif
}

- (void)sortUserData{
    UIAlertController *alertController = [UIAlertController alertStyle:UIAlertControllerStyleActionSheet title:@"appList" message:nil cancel:@"取消" cancelBlock:^(NSString * _Nonnull cancel) {
        
    } confirm:@[@"system",@"user",@"system&user"] confirmBlock:^(NSUInteger index) {
        if (index == 0){
            self.data = [self.result filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"applicationType != %@",@"User"]];
        }else if (index == 1){
            self.data = [self.result filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"applicationType == %@",@"User"]];
        }else{
            self.data = self.result;
        }
        [self.tableView reloadData];
    }];
    [self presentViewController:alertController animated:YES completion:nil];
   
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NSObject performTarget:@"TPAppKindTableViewCell_Class" action:@"initWithTableView:withModel:" object:tableView object:self.data[indexPath.row]] ?: [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [NSObject performTarget:TPRouter.routerClass action:TPRouter.routerJumpUrlParams object:@"TPAppDetailViewController" object:@{@"model":self.data[indexPath.row]}];
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

//
//  TPNetworkMonitorViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/29.
//

#import "TPNetworkMonitorViewController.h"
#import "TPNetworkMonitor.h"
@interface TPNetworkMonitorViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation TPNetworkMonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"网络数据";
    self.dataSource = TPNetworkMonitor.data;
    self.data = self.dataSource;
    [self.tableView reloadData];
}

- (void)textFieldDidChange:(UITextField *)textField{
    self.data = self.dataSource;
    if (textField.text.length) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(TPNetworkModel  * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            if ([evaluatedObject.url.lowercaseString containsString:textField.text.lowercaseString]){
                return YES;
            }
            if ([evaluatedObject.httpMethod.lowercaseString containsString:textField.text.lowercaseString]){
                return YES;
            }
            return  NO;
        }];
        self.data = [self.dataSource filteredArrayUsingPredicate:predicate];
    }
    [self.tableView reloadData];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NSObject performTarget:@"TPNetworkMonitorTableViewCell_Class" action:@"initWithTableView:withModel:" object:tableView object:self.data[indexPath.row]] ?: [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [NSObject performTarget:TPRouter.routerClass action:TPRouter.routerJumpUrlParams object:@"TPPoObjectViewController" object:@{@"object":self.data[indexPath.row]}];
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
            make.top.mas_equalTo(self.textField.mas_bottom);
            make.left.right.bottom.mas_equalTo(0);
        }];
    }
    return _tableView;
}

- (UITextField *)textField{
    if (!_textField){
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"搜索内容";
        _textField.layer.cornerRadius = 6;
        _textField.layer.borderWidth = 0.5;
        _textField.layer.borderColor = UIColor.cCCCCCC.CGColor;
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(40);
        }];
    }
    return _textField;
}

@end

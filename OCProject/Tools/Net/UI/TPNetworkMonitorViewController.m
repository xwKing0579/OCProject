//
//  TPNetworkMonitorViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/29.
//

#import "TPNetworkMonitorViewController.h"
#import "TPNetworkMonitor.h"

@interface TPNetworkMonitorViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *filterView;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSString *path;
@end

@implementation TPNetworkMonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"网络数据";
    self.dataSource = TPNetworkMonitor.data;
    self.data = self.dataSource;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"delete"].original style:(UIBarButtonItemStyleDone) target:self action:@selector(removeNetworkData)];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.filterView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    [self.tableView reloadData];
}

- (void)removeNetworkData{
    [TPNetworkMonitor removeNetData];
    self.dataSource = TPNetworkMonitor.data;
    self.data = self.dataSource;
    [self.tableView reloadData];
}

- (void)textFieldDidChange:(UITextField *)textField{
    [self filterData];
}

- (void)filterData{
    NSArray *dataSource = self.dataSource;
    
    if (self.host.length){
        NSPredicate *hostPre = [NSPredicate predicateWithBlock:^BOOL(TPNetworkModel  * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            if ([evaluatedObject.host containsString:self.host]) return YES;
            return  NO;
        }];
        dataSource = [dataSource filteredArrayUsingPredicate:hostPre];
    }
    
    if (self.path.length){
        NSPredicate *pathPre = [NSPredicate predicateWithBlock:^BOOL(TPNetworkModel  * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            if ([evaluatedObject.path containsString:self.path]) return YES;
            return  NO;
        }];
        dataSource = [dataSource filteredArrayUsingPredicate:pathPre];
    }
    
    NSString *text = self.textField.text.whitespace;
    if (text.length) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(TPNetworkModel  * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            if ([evaluatedObject.url.lowercaseString containsString:text.lowercaseString]){
                return YES;
            }
            if ([evaluatedObject.httpMethod.lowercaseString containsString:text.lowercaseString]){
                return YES;
            }
            if ([evaluatedObject.requestParams.lowercaseString containsString:text.lowercaseString]){
                return YES;
            }
            if ([evaluatedObject.data.lowercaseString containsString:text.lowercaseString]){
                return YES;
            }
            return  NO;
        }];
        dataSource = [dataSource filteredArrayUsingPredicate:predicate];
    }
    self.data = dataSource;
    [self.tableView reloadData];
}

- (void)clickFilterAction:(UIButton *)sender{
    if (sender.tag){
        sender.selected = self.path.length;
    }else{
        sender.selected = self.host.length;
    }
    NSMutableSet *set = [NSMutableSet set];
    for (TPNetworkModel *model in self.dataSource) {
        NSString *result = sender.tag ? model.path : model.host;
        if (result.length) [set addObject:result];
    }
    
    NSMutableArray *titles = [NSMutableArray arrayWithArray:set.allObjects];
    [titles insertObject:sender.tag ? @"全部资源路径" : @"全部域名" atIndex:0];
    if (titles.count) {
        UIAlertController *alert = [UIAlertController alertStyle:UIAlertControllerStyleActionSheet title:sender.titleLabel.text message:nil cancel:@"取消" cancelBlock:^(NSString * _Nonnull cancel) {
            
        } confirms:titles confirmBlock:^(NSUInteger index) {
            NSString *titleString = titles[index];
            if (sender.tag){
                self.path = index?titleString:nil;
            }else{
                self.host = index?titleString:nil;
            }
            
            sender.selected = index;
            [sender setTitle:titleString forState:UIControlStateNormal];
            [sender setTitle:titleString forState:UIControlStateSelected];
            [self filterData];
        }];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (NSString *)cellClass{
    return TPString.tc_network_monitor;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    [TPRouter jumpUrl:TPString.vc_po_object params:@{@"object":self.data[indexPath.row]}];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField{
    [textField resignFirstResponder];
    return YES;
}

- (UITextField *)textField{
    if (!_textField){
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"搜索内容";
        _textField.layer.cornerRadius = 6;
        _textField.layer.borderWidth = 0.5;
        _textField.layer.borderColor = UIColor.ccccccc.CGColor;
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
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

- (UIView *)filterView{
    if (!_filterView){
        _filterView = [[UIView alloc] init];
        
        NSArray *titles = @[@"域名host筛选",@"资源路径path筛选"];
        NSMutableArray *views = [NSMutableArray array];
        for (NSString *title in titles) {
            UIButton *filterBtn = [[UIButton alloc] init];
            filterBtn.tag = [titles indexOfObject:title];
            filterBtn.layer.cornerRadius = 20;
            filterBtn.layer.masksToBounds = YES;
            filterBtn.titleLabel.font = UIFont.font14;
            filterBtn.titleLabel.numberOfLines = 2;
            filterBtn.layer.borderColor = UIColor.cbfbfbf.CGColor;
            filterBtn.layer.borderWidth = 1;
            filterBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
            [filterBtn setTitle:title forState:UIControlStateNormal];
            [filterBtn setTitleColor:UIColor.cbfbfbf forState:UIControlStateNormal];
            [filterBtn setTitleColor:UIColor.redColor forState:UIControlStateSelected];
            [filterBtn addTarget:self action:@selector(clickFilterAction:) forControlEvents:UIControlEventTouchUpInside];
            [_filterView addSubview:filterBtn];
            
            [views addObject:filterBtn];
        }
       
        [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:15 tailSpacing:15];
        [views mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(0);
        }];
        
        [self.view addSubview:_filterView];
        [_filterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.textField.mas_bottom);
            make.height.mas_equalTo(50);
        }];
    }
    return _filterView;
}

@end

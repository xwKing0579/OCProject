//
//  TPNetworkMonitorViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/29.
//

#import "TPNetworkMonitorViewController.h"
#import "TPNetworkMonitor.h"
@interface TPNetworkMonitorViewController ()
@property (nonatomic, strong) UITextField *textField;
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

- (NSString *)cellClass{
    return @"TPNetworkMonitorTableViewCell_Class";
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [NSObject performTarget:TPRouter.routerClass action:TPRouter.routerJumpUrlParams object:@"TPPoObjectViewController" object:@{@"object":self.data[indexPath.row]}];
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

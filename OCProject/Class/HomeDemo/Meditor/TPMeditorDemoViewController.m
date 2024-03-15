//
//  TPMeditorDemoViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/9.
//

#import "TPMeditorDemoViewController.h"

@interface TPMeditorDemoViewController ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *targetTextField;
@property (nonatomic, strong) UITextField *actionTextField;
@property (nonatomic, strong) UITextField *paramsTextField;
@property (nonatomic, strong) UIButton *performButton;
@end

@implementation TPMeditorDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpSubViews];
}

- (void)setUpSubViews{
    self.titleLabel.text = @"中间件一般使用以下三个方法：\n+ (id)performTarget:action:\n+ (id)performAction:\n- (id)performAction:\n如果有参数添加object，超过2个参数使用objects，通过键(object1...n)值对添加到字典中";
    self.targetTextField.text = @"MBProgressHUD".classString;
    self.actionTextField.text = @"showText:";
    self.paramsTextField.text = @"参数是id类型，要尽量保持和接收类型一致";
    [self.performButton setTitle:@"点击执行方法" forState:UIControlStateNormal];
}

- (void)clickPerformAction{
    [NSObject performTarget:self.targetTextField.text action:self.actionTextField.text object:self.paramsTextField.text];
}

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = UIFont.fontBold20;
        _titleLabel.textColor = UIColor.c000000;
        _titleLabel.numberOfLines = 0;
        [self.view addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.top.mas_equalTo(30);
            make.right.mas_equalTo(-30);
        }];
    }
    return _titleLabel;
}

- (UITextField *)targetTextField{
    if (!_targetTextField){
        _targetTextField = [[UITextField alloc] init];
        _targetTextField.placeholder = @"输入类名称，类方法添加后缀".classString;
        _targetTextField.textColor = UIColor.c000000;
        _targetTextField.font = UIFont.font14;
        _targetTextField.layer.cornerRadius = 6;
        _targetTextField.layer.borderWidth = 0.5;
        _targetTextField.layer.borderColor = UIColor.ccccccc.CGColor;
        _targetTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _targetTextField.leftViewMode = UITextFieldViewModeAlways;
        _targetTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:_targetTextField];
        [_targetTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(40);
        }];
    }
    return _targetTextField;
}

- (UITextField *)actionTextField{
    if (!_actionTextField){
        _actionTextField = [[UITextField alloc] init];
        _actionTextField.placeholder = @"输入类或者实例方法名";
        _actionTextField.textColor = UIColor.c000000;
        _actionTextField.font = UIFont.font14;
        _actionTextField.layer.cornerRadius = 6;
        _actionTextField.layer.borderWidth = 0.5;
        _actionTextField.layer.borderColor = UIColor.ccccccc.CGColor;
        _actionTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _actionTextField.leftViewMode = UITextFieldViewModeAlways;
        _actionTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:_actionTextField];
        [_actionTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.top.mas_equalTo(self.targetTextField.mas_bottom).offset(20);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(40);
        }];
    }
    return _actionTextField;
}

- (UITextField *)paramsTextField{
    if (!_paramsTextField){
        _paramsTextField = [[UITextField alloc] init];
        _paramsTextField.placeholder = @"输入参数(以字符串参数类型举例)";
        _paramsTextField.textColor = UIColor.c000000;
        _paramsTextField.font = UIFont.font14;
        _paramsTextField.layer.cornerRadius = 6;
        _paramsTextField.layer.borderWidth = 0.5;
        _paramsTextField.layer.borderColor = UIColor.ccccccc.CGColor;
        _paramsTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _paramsTextField.leftViewMode = UITextFieldViewModeAlways;
        _paramsTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:_paramsTextField];
        [_paramsTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.top.mas_equalTo(self.actionTextField.mas_bottom).offset(20);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(40);
        }];
    }
    return _paramsTextField;
}

- (UIButton *)performButton{
    if (!_performButton){
        _performButton = [[UIButton alloc] init];
        _performButton.titleLabel.font = UIFont.font16;
        _performButton.backgroundColor = UIColor.cff5a00;
        _performButton.layer.cornerRadius = 6;
        _performButton.layer.masksToBounds = YES;
        [_performButton setTitleColor:UIColor.cffffff forState:UIControlStateNormal];
        [_performButton setTitle:@"执行方法" forState:UIControlStateNormal];
        [_performButton addTarget:self action:@selector(clickPerformAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_performButton];
        [_performButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.top.mas_equalTo(self.paramsTextField.mas_bottom).offset(40);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(50);
        }];
    }
    return _performButton;
}
@end

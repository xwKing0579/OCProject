//
//  TPAnalysisDemoViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/10.
//

#import "TPAnalysisDemoViewController.h"

@interface TPAnalysisDemoViewController ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *demoBtn;
@end

@implementation TPAnalysisDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpSubViews];
}

- (void)setUpSubViews{
    self.titleLabel.text = @"无痕埋点，比如页面停留时间、页面路径、点击按钮、点击cell等等，网上很多AOP文章，大体思路就是hook点击方法，在方法添加埋点，支持三方库比如Aspects\n这里提供一种思路给大家参考";
    [self.demoBtn setTitle:@"点击查看demo" forState:UIControlStateNormal];
}

- (void)clickDemoAction{
    [TPRouter jumpUrl:TPString.vc_analysis_click];
}

#pragma mark - setter/getter
- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = UIFont.fontBold16;
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

- (UIButton *)demoBtn{
    if (!_demoBtn){
        _demoBtn = [[UIButton alloc] init];
        _demoBtn.layer.cornerRadius = 6;
        _demoBtn.backgroundColor = UIColor.c1e1e1e;
        [_demoBtn addTarget:self action:@selector(clickDemoAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_demoBtn];
        [_demoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(50);
            make.width.mas_equalTo(230);
            make.height.mas_equalTo(50);
        }];
    }
    return _demoBtn;
}

@end

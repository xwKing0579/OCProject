//
//  TPAnalysisClickTableViewCell.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/10.
//

#import "TPAnalysisClickTableViewCell.h"
#import "TPAnalysisDemoModel.h"
@interface TPAnalysisClickTableViewCell ()
@property (nonatomic, strong) UILabel *clickLabel;
@property (nonatomic, strong) UIButton *clickButton;
@property (nonatomic, strong) UIControl *clickControl;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) TPAnalysisDemoModel *model;
@end

@implementation TPAnalysisClickTableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView withObject:(TPAnalysisDemoModel *)model{
    TPAnalysisClickTableViewCell *cell = [self initWithTableView:tableView];
    cell.model = model;
    cell.clickLabel.text = model.labelString;
    [cell.clickButton setTitle:model.buttonString forState:UIControlStateNormal];
    return cell;
}

- (void)clickButtonAction{
    NSLog(@"按钮点击事件");
}

- (void)clickControlAction{
    NSLog(@"control点击事件");
}

- (void)didTapLabel:(UITapGestureRecognizer *)tapGesture{
    NSLog(@"手势点击事件");
}

- (void)setUpSubViews{
    [self.contentView addSubviews:@[self.clickLabel,self.clickButton,self.clickControl,self.lineView]];
    [_clickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(40);
    }];
    [_clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.clickLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(40);
    }];
    [_clickControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.clickButton.mas_bottom).offset(20);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo (40);
        make.bottom.mas_equalTo(self.lineView).offset(-15);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (UILabel *)clickLabel{
    if (!_clickLabel){
        _clickLabel = [[UILabel alloc] init];
        _clickLabel.textColor = UIColor.c000000;
        _clickLabel.font = UIFont.font14;
        _clickLabel.layer.cornerRadius = 6;
        _clickLabel.layer.borderWidth = 0.5;
        _clickLabel.textAlignment = NSTextAlignmentCenter;
        _clickLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapLabel:)];
        [_clickLabel addGestureRecognizer:tapGesture];
    }
    return _clickLabel;
}

- (UIButton *)clickButton{
    if (!_clickButton){
        _clickButton = [[UIButton alloc] init];
        _clickButton.titleLabel.font = UIFont.font14;
        _clickButton.layer.cornerRadius = 6;
        _clickButton.layer.borderWidth = 0.5;
        [_clickButton setTitleColor:UIColor.c000000 forState:UIControlStateNormal];
        [_clickButton addTarget:self action:@selector(clickButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickButton;
}

- (UIControl *)clickControl{
    if (!_clickControl){
        _clickControl = [[UIControl alloc] init];
        _clickControl.layer.cornerRadius = 6;
        _clickControl.layer.borderWidth = 0.5;
        _clickControl.backgroundColor = UIColor.c1eb65f;
        [_clickControl addTarget:self action:@selector(clickControlAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickControl;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColor.ccccccc;
    }
    return _lineView;
}

@end

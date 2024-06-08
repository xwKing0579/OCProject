//
//  TPJsonObjectTableViewCell.m
//  FXTP
//
//  Created by 王祥伟 on 2024/6/4.
//

#import "TPJsonObjectTableViewCell.h"
#import "TPJsonObjectModel.h"
@interface TPJsonObjectTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *copyBtn;
@end

@implementation TPJsonObjectTableViewCell
+ (instancetype)initWithTableView:(UITableView *)tableView withObject:(TPJsonObjectModel *)model{
    TPJsonObjectTableViewCell *cell = [self initWithTableView:tableView];
    if (model.key) cell.titleLabel.text = [NSString stringWithFormat:@"%@", model.key].whitespace;
    cell.contentLabel.text = [NSString stringWithFormat:@"%@", model.value].whitespace;
    return cell;
}

- (void)setUpSubViews{
    [self.contentView addSubviews:@[self.titleLabel,self.contentLabel,self.lineView,self.copyBtn]];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-45);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(4);
        make.right.equalTo(self.titleLabel);
        make.bottom.mas_equalTo(-10);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    [self.copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
}

- (void)clickCopyAction{
    UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
    [pastboard setString:self.contentLabel.text];

    [TPToastManager showText:@"复制成功"];
}

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = UIFont.fontBold16;
        _titleLabel.textColor = UIColor.c000000;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel){
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = UIFont.font14;
        _contentLabel.textColor = UIColor.c000000;
        _contentLabel.numberOfLines = 100;
    }
    return _contentLabel;
}

- (UIView *)lineView{
    if (!_lineView){
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColor.ccccccc;
    }
    return _lineView;
}

- (UIButton *)copyBtn{
    if (!_copyBtn){
        _copyBtn = [[UIButton alloc] init];
        [_copyBtn setImage:[UIImage imageNamed:@"copy"] forState:UIControlStateNormal];
        [_copyBtn addTarget:self action:@selector(clickCopyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _copyBtn;
}
@end

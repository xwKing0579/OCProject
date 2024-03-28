//
//  TPSpamCodeModelTableViewCell.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/25.
//

#import "TPSpamCodeModelTableViewCell.h"
#import "TPConfoundModel.h"
#import "TPConfoundSetting.h"
@interface TPSpamCodeModelTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textFiled;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) TPConfoundModel *model;
@end

@implementation TPSpamCodeModelTableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView withObject:(TPConfoundModel *)obj{
    TPSpamCodeModelTableViewCell *cell = [self initWithTableView:tableView];
    cell.titleLabel.text = obj.title;
    cell.textFiled.text = obj.content;
    cell.model = obj;
    return cell;
}

- (void)setUpSubViews{
    [self.contentView addSubviews:@[self.titleLabel,self.textFiled,self.lineView]];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(88);
    }];
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(8);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)textFieldDidChange:(UITextField *)textField{
    NSString *text = textField.text.whitespace;
    [TPConfoundModel editContent:text idStr:self.model.idStr];
    self.model.content = text;
}

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = UIFont.font14;
        _titleLabel.textColor = UIColor.c1e1e1e;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UITextField *)textFiled{
    if (!_textFiled){
        _textFiled = [[UITextField alloc] init];
        _textFiled.textColor = UIColor.c333333;
        _textFiled.font = UIFont.font14;
        _textFiled.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _textFiled.leftViewMode = UITextFieldViewModeAlways;
        _textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        rightView.image = [UIImage imageNamed:@"edit"];
        _textFiled.rightView = rightView;
        _textFiled.rightViewMode = UITextFieldViewModeAlways;
        [_textFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textFiled;
}

- (UIView *)lineView{
    if (!_lineView){
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColor.ccccccc;
    }
    return _lineView;
}

@end


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
    TPSpamCodeSetting *codeSet = TPConfoundSetting.sharedManager.spamSet;
    TPSpamCodeFileSetting *fileSet = codeSet.spamFileSet;
    TPSpamCodeWordSetting *wordSet = codeSet.spamWordSet;
    NSString *text = textField.text.whitespace;
    switch (self.model.idStr.intValue) {
        case 121:
            fileSet.projectName = text;
            break;
        case 122:
            fileSet.author = text;
            break;
        case 123:
            fileSet.spamFileNum = text.intValue;
            break;
        case 124:
            fileSet.spamClassPrefix = text;
            break;
        case 131:
            codeSet.spamMethodPrefix = text;
            break;
        case 141:
            wordSet.frequency = text.intValue;
            break;
        case 142:
            wordSet.minLength = text.intValue;
            break;
        case 143:
            wordSet.maxLength = text.intValue;
            break;
        case 144:
            wordSet.blackList = [text componentsSeparatedByString:@","];
            break;
        default:
            break;
    }
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


//
//  TPCrashDetailTableViewCell.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/14.
//

#import "TPCrashDetailTableViewCell.h"

@interface TPCrashDetailTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation TPCrashDetailTableViewCell
+ (instancetype)initWithTableView:(UITableView *)tableView withDic:(NSDictionary *)dic{
    TPCrashDetailTableViewCell *cell = [self initWithTableView:tableView];
    cell.titleLabel.text = dic.allKeys.firstObject;
    
    id value = dic.allValues.firstObject;
    NSMutableString *text = [NSMutableString string];
    if ([value isKindOfClass:[NSString class]]) {
        text = value;
    }else if ([value isKindOfClass:[NSDictionary class]]){
        NSDictionary *dic = (NSDictionary *)value;
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [text appendString:[NSString stringWithFormat:@"key:%@,value:%@",key,obj]];
        }];
    }else if ([value isKindOfClass:[NSArray class]]){
        NSArray *array = (NSArray *)value;
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [text appendString:[NSString stringWithFormat:@"%@\n",obj]];
        }];
    }
    cell.contentLabel.text = text;
    
    return cell;
}

- (void)setUpSubViews{
    [self.contentView addSubviews:@[self.titleLabel,self.contentLabel,self.lineView]];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-15);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(4);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-10);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
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
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIView *)lineView{
    if (!_lineView){
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColor.cCCCCCC;
    }
    return _lineView;
}
@end

//
//  TPFileTableViewCell.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/15.
//

#import "TPFileTableViewCell.h"
@interface TPFileTableViewCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation TPFileTableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView withObject:(TPFileModel *)model{
    TPFileTableViewCell *cell = [self initWithTableView:tableView];
    cell.titleLabel.text = model.fileName;
    cell.contentLabel.text = [NSString sizeString:model.fileSize];
    cell.dateLabel.text = model.fileDate;
    
    NSString *imageString = @"default";
    switch (model.fileType) {
        case TPFileTypeDirectory:
            imageString = @"folder";
            break;
        case TPFileTypeDB:
            imageString = @"db";
            break;
        case TPFileTypeJson:
            imageString = @"json";
            break;
        case TPFileTypePlist:
            imageString = @"plist";
            break;
        case TPFileTypeImage:
            imageString = @"image";
            break;
        case TPFileTypeAudio:
            imageString = @"audio";
            break;
        case TPFileTypeVideo:
            imageString = @"video";
            break;
        case TPFileTypePDF:
            imageString = @"pdf";
            break;
        case TPFileTypePPT:
            imageString = @"ppt";
            break;
        case TPFileTypeDOC:
            imageString = @"doc";
            break;
        case TPFileTypeZip:
            imageString = @"zip";
            break;
        case TPFileTypeHTML:
            imageString = @"html";
            break;
        default:
            break;
    }
    cell.iconImageView.image = [UIImage imageNamed:imageString];
    return cell;
}

- (void)setUpSubViews{
    [self.contentView addSubviews:@[self.iconImageView,self.titleLabel,self.contentLabel,self.dateLabel,self.arrowImageView,self.lineView]];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(36);
        make.centerY.mas_equalTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
        make.right.mas_equalTo(-30);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(4);
        make.bottom.mas_equalTo(-10);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel);
        make.top.bottom.equalTo(self.contentLabel);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(12);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (UIImageView *)iconImageView{
    if (!_iconImageView){
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = UIFont.font16;
        _titleLabel.textColor = UIColor.c000000;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = UIFont.font16;
        _contentLabel.textColor = UIColor.c000000;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLabel;
}

- (UILabel *)dateLabel{
    if (!_dateLabel){
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = UIFont.font12;
        _dateLabel.textColor = UIColor.c333333;
        _dateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _dateLabel;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"arrow"];
    }
    return _arrowImageView;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColor.cCCCCCC;
    }
    return _lineView;
}
@end

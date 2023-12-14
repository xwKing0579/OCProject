//
//  TPDebugToolViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/7.
//

#import "TPDebugToolViewController.h"
#import "TPDebugTool.h"

static NSString *identifier = @"TPDebugToolViewCell";
@interface TPDebugToolViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray <TPDebugToolModel *>*data;
@end

@implementation TPDebugToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"DebugTool";
    [self setUpSubViews];
}

- (void)setUpSubViews{
    self.data = [TPDebugToolModel data];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TPDebugToolViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.model = self.data[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TPDebugToolModel *model = self.data[indexPath.row];
    if (indexPath.row == 0) {
        void(^block)(void) = ^{
            [self setUpSubViews];
        };
        [TPMediator performTarget:model.target action:model.action object:block];
    }else{
        [TPMediator performTarget:model.target action:model.action object:model.url];
    }
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //最小行间距
        layout.minimumLineSpacing = 0;
        //最小列间距
        layout.minimumInteritemSpacing = 0;
        //item大小
        CGFloat width = self.view.width/4;
        layout.itemSize = CGSizeMake(width, width);
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:NSClassFromString(identifier) forCellWithReuseIdentifier:identifier];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (BOOL)controllerRepeat{
    return NO;
}

@end


@interface TPDebugToolViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation TPDebugToolViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.height.mas_equalTo(34);
        make.top.mas_equalTo(15);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.imageView.mas_bottom).offset(4);
    }];
}

- (void)setModel:(TPDebugToolModel *)model{
    self.titleLabel.text = model.title;
    self.imageView.image = [UIImage imageNamed:model.image];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = UIFont.font16;
        _titleLabel.textColor = UIColor.c000000;
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

@end


@implementation TPDebugToolModel

+ (NSArray *)data{
    NSString *envi = [NSString stringWithFormat:@"环境：%@",[TPMediator performTarget:@"TPEnviConfig_Class" action:@"enviToSting"]];
    NSArray *data = @[
        @{@"title":envi,@"image":@"setting",@"target":@"TPEnviConfig_Class",@"action":@"enviConfig:"},
        @{@"title":@"路由",@"image":@"router",@"target":@"TPRouter_Class",@"action":@"routerEntry"},
        @{@"title":@"app信息",@"image":@"appInfo",@"target":@"TPRouter_Class",@"action":@"jumpUrl:",@"url":@"native/TPAppInfoViewController"},
        @{@"title":@"crash信息",@"image":@"crash",@"target":@"TPRouter_Class",@"action":@"jumpUrl:",@"url":@"native/TPCrashViewController"},
    ];
    return [NSArray yy_modelArrayWithClass:[self class] json:data];
}

@end

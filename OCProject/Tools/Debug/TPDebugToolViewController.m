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
@property (nonatomic, copy) id block;
@end

@implementation TPDebugToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"DebugTool";
    [self setUpSubViews];
}

- (void)setUpSubViews{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageOriginal:[UIImage imageNamed:@"switch"]] style:(UIBarButtonItemStyleDone) target:self action:@selector(clickSwitchAction)];
    self.data = [TPDebugToolModel data];
    [self.collectionView reloadData];
}

- (void)clickSwitchAction{
    [NSObject performTarget:TPRouter.routerClass action:TPRouter.routerJumpUrlParams object:@"TPDebugSwitchViewController"];
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
    id obj = model.url;
    if ([model.action isEqualToString:@"enviConfig:"]) {
        void (^block)(void) = ^{
            [self setUpSubViews];
        };
        obj = block;
        
        //self.block = block; //内存泄漏测试
    }
    [NSObject performTarget:model.target ?: TPRouter.routerClass action:model.action ?: TPRouter.routerJumpUrl object:obj];
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
        make.top.equalTo(self.imageView.mas_bottom).offset(6);
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
    NSString *envi = [NSString stringWithFormat:@"环境:%@",[NSObject performTarget:@"TPEnviConfig_Class" action:@"enviToSting"]];

    NSMutableString *startTime = [NSMutableString stringWithString:@"启动时间:"];
    id value = [[NSUserDefaults standardUserDefaults] valueForKey:@"kTPStartupTimeKey"];
    if (value)[startTime appendString:[NSString stringWithFormat:@"%.3f",[value doubleValue]]];
   
    NSArray *data = @[
        @{@"title":startTime,@"image":@"startup"},
        @{@"title":@"路由",@"image":@"router",@"action":@"routerEntry"},
        @{@"title":envi,@"image":@"setting",@"target":@"TPEnviConfig_Class",@"action":@"enviConfig:"},
        
        @{@"title":@"app信息",@"image":@"appInfo",@"url":@"TPAppInfoViewController"},
        @{@"title":@"app文件",@"image":@"file",@"url":@"TPFileViewController"},
        @{@"title":@"UserDefaults",@"image":@"data",@"url":@"TPUserDefaultsController"},
        @{@"title":@"可用字体",@"image":@"font",@"url":@"TPFontViewController"},
        @{@"title":@"内存泄漏",@"image":@"leaks",@"url":@"TPLeaksViewController"},
        @{@"title":@"本机app",@"image":@"app",@"url":@"TPAppKindViewController"},
        
        @{@"title":@"打印日志",@"image":@"log",@"url":@"TPLogViewController"},
        @{@"title":@"崩溃信息",@"image":@"crash",@"url":@"TPCrashViewController"},
        @{@"title":@"卡顿检测",@"image":@"caton",@"url":@"TPMonitorViewController"},
        @{@"title":@"视图层级",@"image":@"ui",@"url":@"TPUIHierarchyViewController"},
    ];
    
    return [NSArray yy_modelArrayWithClass:[self class] json:data];
}

@end

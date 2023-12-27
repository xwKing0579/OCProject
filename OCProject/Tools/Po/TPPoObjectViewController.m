//
//  TPPoObjectViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/26.
//

#import "TPPoObjectViewController.h"

@interface TPPoObjectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *data;
@end

@implementation TPPoObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"po对象";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"custom" style:(UIBarButtonItemStyleDone) target:self action:@selector(customPropertyList)];
    self.data = self.object.propertyList;
    [self.tableView reloadData];
}

- (void)customPropertyList{
    if (!self.object) return;
    
    NSMutableArray *propertyList = [NSMutableArray array];
    if ([self.object isKindOfClass:[UILabel class]]){
        [propertyList addObjectsFromArray:[self.object customPropertyList:@[@"text",@"font",@"textColor",@"textAlignment",@"numberOfLines",@"lineBreakMode"]]];
    }
    if ([self.object isKindOfClass:[UIImageView class]]){
        [propertyList addObjectsFromArray:[self.object customPropertyList:@[@"image",@"sd_currentImageURL"]]];

        UIImageView *imageView = (UIImageView *)self.object;
        if (imageView.image) [propertyList addObjectsFromArray:[imageView.image.imageAsset customPropertyList:@[@"assetName",@"containingBundle"]]];
    }
    if ([self.object isKindOfClass:[UIButton class]]){
        [propertyList addObjectsFromArray:[self.object customPropertyList:@[@"sd_currentImageURL"]]];
    }
    if ([self.object isKindOfClass:[UITextView class]]){
        [propertyList addObjectsFromArray:[self.object customPropertyList:@[@"text",@"font",@"textColor",@"textAlignment"]]];
    }
    if ([self.object isKindOfClass:[UITextField class]]){
        [propertyList addObjectsFromArray:[self.object customPropertyList:@[@"text",@"font",@"textColor",@"textAlignment",@"placeholder",@"attributedText"]]];
    }
    if ([self.object isKindOfClass:[UIView class]]){
        [propertyList addObjectsFromArray:[self.object customPropertyList:@[@"frame",@"bounds",@"backgroundColor",@"contentMode"]]];
        UIView *view = (UIView *)self.object;
        [propertyList addObjectsFromArray:[view.layer customPropertyList:@[@"cornerRadius",@"borderWidth",@"borderColor"]]];
    }
    
    [propertyList addObject:@{@"类":NSStringFromClass(self.object.class)}];
    [propertyList addObject:@{@"内存地址":[NSString stringWithFormat:@"%p",self.object]}];
    [propertyList addObject:@{@"指针地址":[NSString stringWithFormat:@"%lu",(uintptr_t)self.object]}];
    [propertyList addObject:@{@"描述":self.object.description}];
    self.data = propertyList;
    [self.tableView reloadData];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NSObject performTarget:@"TPPoObjectTableViewCell_Class" action:@"initWithTableView:withDic:" object:tableView object:self.data[indexPath.row]] ?: [UITableViewCell new];
}

#pragma mark -- setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0.01)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0.01)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}

@end

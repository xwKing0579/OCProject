//
//  TPFileViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/15.
//

#import "TPFileViewController.h"
#import "TPFileManager.h"

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TPFileViewController ()<UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <TPFileModel *>*data;
@property (nonatomic, strong) UIDocumentInteractionController *doc;
@end

@implementation TPFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.name ?: @"文件";
    
    self.data = self.path ? [TPFileManager dataForFilePath:self.path] : [TPFileManager defaultFile];
    [self.tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.doc = nil;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NSObject performTarget:@"TPFileTableViewCell_Class" action:@"initWithTableView:withModel:" object:tableView object:self.data[indexPath.row]] ?: [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TPFileModel *model = self.data[indexPath.row];
    if (model.isDirectory){
        [NSObject performTarget:TPRouter.routerClass action:TPRouter.routerJumpUrl object:[NSString stringWithFormat:@"TPFileViewController?name=%@&path=%@",model.fileName,model.filePath]];
    }else{
        
        if (model.fileType == TPFileTypeJson){
            NSString *jsonString = [NSString stringWithContentsOfFile:model.filePath encoding:NSUTF8StringEncoding error:nil];
            NSData *jaonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jaonData options:NSJSONReadingMutableContainers error:nil];
            if (dic) [NSObject performTarget:TPRouter.routerClass action:TPRouter.routerJumpUrlParams object:[NSString stringWithFormat:@"TPFileDataViewController?fileName=%@",model.fileName] object:@{@"dic":dic}];
        }else if (model.fileType == TPFileTypeVideo){
            AVPlayerViewController *player = [[AVPlayerViewController alloc] init];
            player.player = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:model.filePath]];
            [self presentViewController:player animated:YES completion:nil];
        }else{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:model.filePath];
            if (dic) {
                [NSObject performTarget:TPRouter.routerClass action:TPRouter.routerJumpUrlParams object:[NSString stringWithFormat:@"TPFileDataViewController?fileName=%@",model.fileName] object:@{@"dic":dic}];
            }else{
                UIDocumentInteractionController *doc = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:model.filePath]];
                doc.delegate = self;
                self.doc = doc;
                BOOL canOpen = [doc presentPreviewAnimated:YES];
                if (!canOpen) {
                    [NSObject performTarget:@"MBProgressHUD_Class" action:@"showText:" object:@"该文件还没有添加预览模式"];
                }
            }
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.path) return [UIView new];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 300)];
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    TPFileModel *model = self.data[section];
    label.text = [NSString stringWithFormat:@"沙盒路径：\n%@",model.filePath];
    label.numberOfLines = 0;
    label.textColor = UIColor.c000000;
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return self.path ? 0 : 300;
}

#pragma mark - UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

- (nullable UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
    return self.view;
}

- (BOOL)controllerOverlap{
    return YES;
}

#pragma mark -- setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0.01)];
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

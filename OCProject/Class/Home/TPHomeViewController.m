//
//  TPHomeViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "TPHomeViewController.h"
#import "TPFileManager.h"

@interface TPHomeViewController ()

@end

@implementation TPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.data = @[@"TPRouterDemoViewController?title=路由演示demo",
                  @"TPMeditorDemoViewController?title=中间件demo",
                  @"TPAnalysisDemoViewController?title=无痕埋点demo"];
//    [TPNetworkManager post:@"fxtpplatform/information/app/live/anonymous/queryDailyLiveStatus" params:nil success:^(id  _Nonnull responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(TPNetworkError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
}

- (NSString *)cellClass{
    return @"TPHomeTableViewCell_Class";
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [TPRouter jumpUrl:self.data[indexPath.row]];
}

@end

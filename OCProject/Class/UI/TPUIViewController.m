//
//  TPUIViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/8.
//

#import "TPUIViewController.h"

@interface TPUIViewController ()

@end

@implementation TPUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.data = @[@"TPForbidShotDemoViewController?title=禁止截屏demo",
                  @"TPiCarouselViewController?title=iCarousel演示demo",
                  @"TPEmptyDataViewController?title=emptyData演示demo",];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [TPRouter jumpUrl:self.data[indexPath.row]];
}

@end

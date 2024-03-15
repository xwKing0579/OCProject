//
//  TPUiViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/14.
//

#import "TPUiViewController.h"

@interface TPUiViewController ()

@end

@implementation TPUiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.data = @[ROUTER_DEMO(TPString.vc_forbid_shot_demo,@"禁止截屏demo"),
                  ROUTER_DEMO(TPString.vc_i_carousel,@"iCarousel演示demo"),
                  ROUTER_DEMO(TPString.vc_empty_data,@"emptyData演示demo"),
                  ROUTER_DEMO(TPString.vc_crypto,@"加解密演示demo"),
                  ROUTER_DEMO(TPString.vc_toast,@"toast演示demo"),
                  ROUTER_DEMO(TPString.vc_pop_views,@"弹框优先级演示demo")];
    [self.tableView reloadData];
}

@end

//
//  TPTabBarController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "TPTabBarController.h"
#import "TPBaseNavigationController.h"
@interface TPTabBarController ()

@end

@implementation TPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additio/var/folders/1t/4dl17tv96w94hzs02x__240c0000gn/T/simulator_screenshot_EEE35BAC-5627-4610-AF68-8F8CA6DFFB4E.pngnal setup after loading the view.
    
    NSArray *vcs = @[TPRouter.home,TPRouter.web,@"TestViewController",@"TestViewController"];
    NSArray *names = @[@"微信",@"通讯录",@"优化",@"我"];
    NSArray *images = @[@"mainframe_normal",@"contacts_normal",@"discover_normal",@"me_normal"];
    for (int i = 0; i < vcs.count; i++) {
        [self setUpViewControllersInNavClass:TPBaseNavigationController.class rootClass:NSClassFromString(vcs[i]) tabBarName:names[i] tabBarImageName:images[i] size:UIFont.font12 color:UIColor.cCCCCCC selColor:UIColor.c1EB65F];
    }
    
    if (@available (iOS 15.0, *)) {
         UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
         [appearance configureWithOpaqueBackground];
         appearance.backgroundColor = UIColor.cFFFFFF;
         self.tabBar.standardAppearance = appearance;
         self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance;
     } else {
         self.tabBar.barTintColor = UIColor.cFFFFFF;
     }
}

@end

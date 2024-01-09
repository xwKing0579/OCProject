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
    
    NSArray *vcs = @[TPRouter.home,TPRouter.ui,TPRouter.mine];
    NSArray *names = @[@"home",@"ui",@"mine"];
    for (int i = 0; i < vcs.count; i++) {
        [self setUpViewControllersInNavClass:TPBaseNavigationController.class rootClass:NSClassFromString(vcs[i]) tabBarName:names[i] tabBarImageName:names[i]];
    }
    
    if (@available (iOS 15.0, *)) {
         UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
         [appearance configureWithOpaqueBackground];
         appearance.backgroundColor = UIColor.cffffff;
         self.tabBar.standardAppearance = appearance;
         self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance;
     } else {
         self.tabBar.barTintColor = UIColor.cffffff;
     }
}

@end

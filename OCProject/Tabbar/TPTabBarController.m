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
    
    NSArray *names = @[TPString.vc_home,TPString.vc_ui,TPString.vc_mine];
    for (int i = 0; i < names.count; i++) {
        NSString *vcName = names[i];
        [self setUpViewControllersInNavClass:TPBaseNavigationController.class rootClass:NSClassFromString(vcName) tabBarName:vcName.abbr tabBarImageName:vcName.abbr];
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

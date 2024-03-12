//
//  TPTabBarController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "TPTabBarController.h"
#import "TPBaseNavigationController.h"
#import "TPRouter+Class.h"
@interface TPTabBarController ()

@end

@implementation TPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *names = @[@"home",@"ui",@"mine"];
    for (int i = 0; i < names.count; i++) {
        NSString *action = [NSString stringWithFormat:@"vc_%@",names[i]];
        NSString *vcName = [TPRouter performAction:action];
        [self setUpViewControllersInNavClass:TPBaseNavigationController.class rootClass:NSClassFromString([TPRouter classValue][vcName]) tabBarName:names[i] tabBarImageName:names[i]];
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

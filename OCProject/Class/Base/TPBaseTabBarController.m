//
//  TPBaseTabBarController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "TPBaseTabBarController.h"

@interface TPBaseTabBarController ()

@end

@implementation TPBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setUpViewControllersInNavClass:(Class)navClass
                             rootClass:(Class)rootClass
                            tabBarName:(NSString *)name
                       tabBarImageName:(NSString *)imageName{
    [self setUpViewControllersInNavClass:navClass rootClass:rootClass tabBarName:name tabBarImageName:imageName size:[UIFont systemFontOfSize:12] color:[UIColor grayColor] selColor:[UIColor whiteColor]];
}

- (void)setUpViewControllersInNavClass:(Class)navClass
                             rootClass:(Class)rootClass
                            tabBarName:(NSString *)name
                       tabBarImageName:(NSString *)imageName
                                  size:(UIFont *)size
                                 color:(UIColor *)color
                              selColor:(UIColor *)selColor{
    __kindof UINavigationController *nav = [[navClass  alloc] initWithRootViewController:[rootClass new]];
    
    nav.title = name;//tabbar
    nav.navigationItem.title = name;//nav
    nav.tabBarItem.image = [UIImage imageNamed:imageName];
    NSString *selectedImage = [NSString stringWithFormat:@"%@_sel",imageName];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    [nav.tabBarItem setTitleTextAttributes:
     @{NSForegroundColorAttributeName:color,
                  NSFontAttributeName:size}
                             forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:
     @{NSForegroundColorAttributeName:selColor,
                  NSFontAttributeName:size}
                             forState:UIControlStateSelected];
    [self addChildViewController:nav];
}

@end

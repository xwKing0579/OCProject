//
//  TPBaseNavigationController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "TPBaseNavigationController.h"

@interface TPBaseNavigationController ()

@end

@implementation TPBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.translucent = NO;
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc]init];
    appearance.backgroundColor = [UIColor whiteColor];
    self.navigationBar.standardAppearance =  appearance;
    self.navigationBar.scrollEdgeAppearance = appearance;
}

@end

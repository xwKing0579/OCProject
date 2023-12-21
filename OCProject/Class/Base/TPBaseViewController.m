//
//  TPBaseViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "TPBaseViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface TPBaseViewController ()

@end

@implementation TPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.navigationController.childViewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStyleDone) target:self action:@selector(backViewController)];
    }else if (self.presentingViewController){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"close"] style:(UIBarButtonItemStyleDone) target:self action:@selector(backViewController)];
    }
    self.navigationItem.leftBarButtonItem.tintColor = UIColor.c000000;
    self.fd_prefersNavigationBarHidden = [self hideNavigationBar];
    self.view.backgroundColor = UIColor.cFFFFFF;
}

///back
- (void)backViewController{
    [TPMediator performTarget:TPRouter.routerClass action:TPRouter.routerBack];
}

///hidden navbar
- (BOOL)hideNavigationBar{
    return NO;
}

- (BOOL)controllerOverlap{
    return NO;
}

@end

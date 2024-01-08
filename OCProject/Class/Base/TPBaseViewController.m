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
    
    UIImage *image;
    if (self.navigationController.childViewControllers.count > 1) {
        image = [UIImage imageNamed:@"back"].original;
    }else if (self.presentingViewController){
        image = [UIImage imageNamed:@"close"].original;
    }
    if (image) self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:(UIBarButtonItemStyleDone) target:self action:@selector(backViewController)];
    self.navigationItem.leftBarButtonItem.tintColor = UIColor.c000000;
    self.fd_prefersNavigationBarHidden = [self hideNavigationBar];
    self.view.backgroundColor = UIColor.cffffff;
}

///back
- (void)backViewController{
    [NSObject performTarget:TPRouter.routerClass action:TPRouter.routerBack];
}

///hidden navbar
- (BOOL)hideNavigationBar{
    return NO;
}

- (BOOL)controllerOverlap{
    return NO;
}

@end

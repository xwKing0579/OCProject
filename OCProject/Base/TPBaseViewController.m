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
    
    NSString *imageString;
    if (self.navigationController.childViewControllers.count > 1) {
        imageString = @"back";
    }else if (self.presentingViewController){
        imageString = @"close";
    }
    if (imageString) {
        UIImage *image = [UIImage imageNamed:imageString].original;
        if ([self backButtonColor]) image = [image imageWithTintColor:[self backButtonColor]];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:(UIBarButtonItemStyleDone) target:self action:@selector(backViewController)];
    }
    self.fd_interactivePopDisabled = [self disableNavigationBar];
    self.fd_prefersNavigationBarHidden = [self hideNavigationBar];
    self.view.backgroundColor = UIColor.cffffff;
}

///back
- (void)backViewController{
    [TPRouter back];
}

///hidden navbar
- (BOOL)hideNavigationBar{
    return NO;
}

- (BOOL)disableNavigationBar{
    return NO;
}

- (UIColor *)backButtonColor{
    return nil;
}
@end

//
//  TPLeakObjectViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/22.
//

#import "TPLeakObjectViewController.h"

@interface TPLeakObjectViewController ()

@end

@implementation TPLeakObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"红色框为泄漏对象";
    
    if ([self.object isKindOfClass:[UIViewController class]]){
        UIViewController *vc = (UIViewController *)self.object;
        [self addChildViewController:vc];
        [self.view addSubview:vc.view];
        vc.view.center = self.view.center;
        
        vc.view.userInteractionEnabled = NO;
        vc.view.layer.borderWidth = 0.5;
        vc.view.layer.borderColor = UIColor.redColor.CGColor;
    }else if ([self.object isKindOfClass:[UIView class]]) {
        UIView *view = (UIView *)self.object;
        [self.view addSubview:view];
        view.center = self.view.center;
        
        view.userInteractionEnabled = NO;
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = UIColor.redColor.CGColor;
    }else if ([self.object isKindOfClass:[NSObject class]]) {
        NSString *desc = [self.object description];
        UILabel *label = [[UILabel alloc] init];
        label.text = desc;
        label.font = UIFont.font16;
        label.textColor = UIColor.redColor;
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
        }];
    }
}

@end

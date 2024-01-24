//
//  TPForbidShotDemoViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/8.
//

#import "TPForbidShotDemoViewController.h"

@interface TPForbidShotDemoViewController ()

@end

@implementation TPForbidShotDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isForbidShot = YES;
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = @"\n禁止截图和录屏\n\n模拟器不支持请用真机尝试\n";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
    }];
}

@end

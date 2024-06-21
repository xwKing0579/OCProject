//
//  TPCardItemViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/6/19.
//

#import "TPCardItemViewController.h"
#import "YGCardContainerView.h"
@interface TPCardItemViewController ()

@end

@implementation TPCardItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    YGCardContainerView *view = [[YGCardContainerView alloc] initWithFrame:CGRectMake(0, 100, self.view.width, self.view.height-200)];
    [self.view addSubview:view];
}



@end

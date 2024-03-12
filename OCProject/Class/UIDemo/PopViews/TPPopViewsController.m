//
//  TPPopViewsController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/12.
//

#import "TPPopViewsController.h"
#import "TPOperationManager.h"
@interface TPPopViewsController ()

@end

@implementation TPPopViewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ///第一任务添加队列会立即执行，优先级只有五个等级（参考NSOperationQueuePriority）
    NSArray *colors = @[UIColor.grayColor,UIColor.redColor,UIColor.greenColor,UIColor.blueColor];
    for (int i = 0; i < colors.count; i++) {
        UIColor *color = colors[i];
        UIButton *btn = [[UIButton alloc] initWithFrame:self.view.bounds];
        btn.backgroundColor = color;
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        TPOperationModel *model = [TPOperationModel new];
        model.subView = btn;
        model.superView = self.view;
        model.block = ^(NSOperation * _Nonnull operation, TPOperationModel * _Nonnull model) {
            //这里处理你要执行的demo
            dispatch_async(dispatch_get_main_queue(), ^{
                [model.superView ?: UIViewController.window addSubview:model.subView];
                [UIView animateWithDuration:2 animations:^{
                    CGAffineTransform transform1 = CGAffineTransformMakeRotation(M_PI);
                    CGAffineTransform transform2 = CGAffineTransformScale(transform1, 0.5, 0.5);
                    model.subView.transform = transform2;
                }];
            });
        };
        [TPOperationManager addOperationModel:model];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //如果superView是当前view，需要注意内存泄漏问题
    [self.view removeAllSubView];
    [TPOperationManager removeAllOperation];
}

- (void)clickBtnAction:(UIButton *)sender{
    [sender removeFromSuperview];
    [TPOperationManager removeOperationForView:sender];
}

@end

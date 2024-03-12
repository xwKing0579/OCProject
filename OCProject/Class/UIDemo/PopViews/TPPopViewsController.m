//
//  TPPopViewsController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/12.
//

#import "TPPopViewsController.h"
#import "TPOperationManager.h"
@interface TPPopViewsController ()
@property (nonatomic, strong) NSMutableArray *models;
@end

@implementation TPPopViewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ///第一任务添加队列会立即执行，优先级只有五个等级（参考NSOperationQueuePriority）
    NSArray *colors = @[UIColor.grayColor,UIColor.redColor,UIColor.greenColor,UIColor.blueColor];
    self.models = [NSMutableArray array];
    for (int i = 0; i < colors.count; i++) {
        UIColor *color = colors[i];
        UIButton *btn = [[UIButton alloc] initWithFrame:self.view.bounds];
        btn.backgroundColor = color;
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        TPOperationModel *model = [TPOperationModel new];
        
        TPWeakSelf
        model.block = ^(NSOperation * _Nonnull operation, TPOperationModel * _Nonnull model) {
            //这里处理你要执行的demo
            dispatch_async(dispatch_get_main_queue(), ^{
                TPStrongSelfElseReturn
                [self.view addSubview:btn];
                [UIView animateWithDuration:2 animations:^{
                    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
                    btn.transform = CGAffineTransformScale(transform, 0.5, 0.5);
                }];
            });
        };
        
        [self.models addObject:model];
        [TPOperationManager addOperationModel:model];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    ///未完成task引用self，调用以下方法避免内存泄漏
    [TPOperationManager removeAllOperation];
}

- (void)clickBtnAction:(UIButton *)sender{
    [sender removeFromSuperview];
    [TPOperationManager removeOperationForModel:self.models[sender.tag]];
}

@end

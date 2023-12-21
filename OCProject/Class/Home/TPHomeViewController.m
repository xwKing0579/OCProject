//
//  TPHomeViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "TPHomeViewController.h"
#import "TPFileManager.h"
@interface TPHomeViewController ()

@end

@implementation TPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [TPNetworkManager post:@"fxtpplatform/information/app/live/anonymous/queryDailyLiveStatus" params:nil success:^(id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(TPNetworkError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:btn];
    NSString *url = @"https://img1.baidu.com/it/u=2825014562,3166058568&fm=253&fmt=auto&app=120&f=JPEG?w=1280&h=800";
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        [btn setImage:image forState:UIControlStateNormal];
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [TPMediator performTarget:TPRouter.routerClass action:TPRouter.routerJumpUrl object:@"test"];
    //制造崩溃
//    [self performSelector:NSSelectorFromString(@"sdsa")];
}

- (BOOL)hideNavigationBar{
    return YES;
}


@end

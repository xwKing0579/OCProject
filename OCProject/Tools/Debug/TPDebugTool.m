//
//  TPDebugTool.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/7.
//

#import "TPDebugTool.h"
#import "UIDevice+Category.h"
#import "UIViewController+Category.h"

@interface TPDebugTool ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIWindow *debugWindow;
@end

@implementation TPDebugTool

+ (instancetype)sharedManager {
    static TPDebugTool *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [self new];
    });
    
    return sharedManager;
}

+ (void)start{
#ifdef DEBUG
    [self sharedManager].debugWindow.hidden = NO;
#endif
}

+ (void)stop{
#ifdef DEBUG
    [self sharedManager].debugWindow.hidden = YES;
#endif
}

- (void)didTap:(UITapGestureRecognizer *)tapGesture{
    NSString *vcString = @"TPDebugToolViewController";
    BOOL jump = YES;
    for (UIViewController *vc in UIViewController.currentViewController.navigationController.viewControllers) {
        if ([vc isKindOfClass:NSClassFromString(vcString)]){
            jump = NO;
            break;
        }
    }
    if (jump) [TPMediator performTarget:TPRouter.routerClass action:TPRouter.routerJumpUrl object:@"native/TPDebugToolViewController/present?navigationController=TPBaseNavigationController"];
}

- (void)dragable:(UIPanGestureRecognizer *)sender{
    CGPoint transP = [sender translationInView:self.debugWindow];
    self.debugWindow.transform = CGAffineTransformTranslate(self.debugWindow.transform, transP.x, transP.y);
    [sender setTranslation:CGPointZero inView:self.debugWindow];
    if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2 animations:^{
            if (self.debugWindow.x < 0) self.debugWindow.x = 0;
            if (self.debugWindow.x > UIScreen.mainScreen.bounds.size.width-self.debugWindow.width) self.debugWindow.x = UIScreen.mainScreen.bounds.size.width-self.debugWindow.width;
            if (self.debugWindow.y < UIDevice.statusBarHeight) self.debugWindow.y = UIDevice.statusBarHeight;
            if (self.debugWindow.y > UIScreen.mainScreen.bounds.size.height-self.debugWindow.height) self.debugWindow.y = UIScreen.mainScreen.bounds.size.height-self.debugWindow.height;
        }];
    }
}

- (UIWindow *)debugWindow{
    if (!_debugWindow){
        _debugWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height/2, 60, 60)];
        _debugWindow.hidden = NO;
        _debugWindow.backgroundColor = [UIColor grayColor];
        _debugWindow.layer.cornerRadius = 30;
        _debugWindow.layer.masksToBounds = YES;
        _debugWindow.windowLevel = UIWindowLevelAlert+1;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        tapGesture.delegate = self;
        [_debugWindow addGestureRecognizer:tapGesture];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragable:)];
        [_debugWindow addGestureRecognizer:pan];
        
        id fps = [TPMediator performTarget:@"FPSLabel_Class" action:@"new"];
        if([fps isKindOfClass:[UILabel class]]) {
            UILabel *fpsLabel = (UILabel *)fps;
            fpsLabel.frame = _debugWindow.bounds;
            [_debugWindow addSubview:fps];
        }
                  
        if (@available(iOS 13.0, *)) {
            [[NSNotificationCenter defaultCenter] addObserverForName:UISceneWillConnectNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
                if ([[note.object class] isEqual:[UIWindowScene class]]){
                    self->_debugWindow.windowScene = note.object;
                }
            }];
            for (UIWindowScene *windowScene in [UIApplication sharedApplication].connectedScenes) {
                if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                    _debugWindow.windowScene = windowScene;
                    break;
                }
            }
        }
    }
    return _debugWindow;
}
@end

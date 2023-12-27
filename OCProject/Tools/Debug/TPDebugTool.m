//
//  TPDebugTool.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/7.
//

#import "TPDebugTool.h"
#import "UIDevice+Category.h"
#import "UIViewController+Category.h"
#import "TPUIHierarchyManager.h"

@interface TPDebugTool ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIWindow *debugWindow;
@property (nonatomic, strong) UILabel *UILabel;
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
    [self didChangeUIHierarchy];
#endif
}

+ (void)stop{
#ifdef DEBUG
    [self sharedManager].debugWindow.hidden = YES;
#endif
}

+ (void)didChangeUIHierarchy{
    TPDebugTool *manager = [self sharedManager];
    if ([TPUIHierarchyManager isOn]) {
        [manager.debugWindow addSubview:manager.UILabel];
        manager.debugWindow.width = 60*2;
        manager.UILabel.frame = CGRectMake(60, 0, 60, 60);
    }else{
        [manager.UILabel removeFromSuperview];
        manager.debugWindow.width = 60;
    }
}

- (void)didTapUI:(UITapGestureRecognizer *)tapGesture{
    id obj = [NSObject performTarget:@"TPUIHierarchyManager_Class" action:@"currentUIHierarchy:" object:UIViewController.window];
    if (!obj) return;
        
    NSString *vcString = @"TPUIHierarchyViewController";
    BOOL showing = NO;
    for (UIViewController *vc in UIViewController.currentViewController.navigationController.childViewControllers){
        if ([vc isKindOfClass:NSClassFromString(vcString)]){
            showing = YES;
        }
    }
    if (!showing) [NSObject performTarget:TPRouter.routerClass action:TPRouter.routerJumpUrlParams object:vcString object:@{@"model":obj}];
}

- (void)didTapFPS:(UITapGestureRecognizer *)tapGesture{
    NSString *vcString = @"TPDebugToolViewController";
    BOOL jump = YES;
    for (UIViewController *vc in UIViewController.currentViewController.navigationController.viewControllers) {
        if ([vc isKindOfClass:NSClassFromString(vcString)]){
            jump = NO;
            break;
        }
    }
    if (jump) [NSObject performTarget:TPRouter.routerClass action:TPRouter.routerJumpUrl object:@"TPDebugToolViewController/present?navigationController=UINavigationController"];
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
        _debugWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height*0.66, 60, 60)];
        _debugWindow.hidden = NO;
        _debugWindow.backgroundColor = [UIColor clearColor];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragable:)];
        [_debugWindow addGestureRecognizer:pan];
        
        id fps = [NSObject performTarget:@"FPSLabel_Class" action:@"new"];
        if([fps isKindOfClass:[UILabel class]]) {
            UILabel *fpsLabel = (UILabel *)fps;
            fpsLabel.frame = _debugWindow.bounds;
            fpsLabel.layer.cornerRadius = 30;
            fpsLabel.layer.masksToBounds = YES;
            fpsLabel.backgroundColor = [UIColor grayColor];
            [_debugWindow addSubview:fps];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapFPS:)];
            tapGesture.delegate = self;
            [fpsLabel addGestureRecognizer:tapGesture];
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

- (UILabel *)UILabel{
    if (!_UILabel){
        _UILabel = [[UILabel alloc] init];
        _UILabel.textColor = UIColor.cFFFFFF;
        _UILabel.backgroundColor = UIColor.redColor;
        _UILabel.text = @"UI";
        _UILabel.font = UIFont.fontBold16;
        _UILabel.layer.cornerRadius = 30;
        _UILabel.layer.masksToBounds = YES;
        _UILabel.textAlignment = NSTextAlignmentCenter;
        _UILabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapUI:)];
        tapGesture.delegate = self;
        [_UILabel addGestureRecognizer:tapGesture];
    }
    return _UILabel;
}
@end

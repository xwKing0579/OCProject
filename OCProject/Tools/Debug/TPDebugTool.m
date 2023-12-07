//
//  TPDebugTool.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/7.
//

#import "TPDebugTool.h"

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
    [TPMediator performTarget:TPRouterModel.routerClass action:TPRouterModel.routerJumpUrl object:@"native/web?url=https://juejin.cn"];
}

- (UIWindow *)debugWindow{
    if (!_debugWindow){
        _debugWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height/2, 60, 60)];
        _debugWindow.hidden = NO;
        _debugWindow.backgroundColor = [UIColor grayColor];
        _debugWindow.layer.cornerRadius = 30;
        _debugWindow.layer.masksToBounds = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        tapGesture.delegate = self;
        [_debugWindow addGestureRecognizer:tapGesture];
        
        id fps = [TPMediator performTarget:@"FPSLabel_Class" action:@"new"];
        if([fps isKindOfClass:[UILabel class]]) {
            UILabel *fpsLabel = (UILabel *)fps;
            fpsLabel.frame = _debugWindow.bounds;
            [_debugWindow addSubview:fps];
        }
                  
        if (@available(iOS 13.0, *)) {
            [[NSNotificationCenter defaultCenter] addObserverForName:UISceneWillConnectNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
                self->_debugWindow.windowScene = note.object;
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

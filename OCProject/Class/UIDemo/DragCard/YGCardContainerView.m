//
//  YGCardContainerView.m
//  OCProject
//
//  Created by 王祥伟 on 2024/6/19.
//

#import "YGCardContainerView.h"
#import "YGCardItemView.h"

@interface YGCardContainerView ()
@property (nonatomic, assign) CGRect topRect;
@property (nonatomic, assign) CGRect bottomRect;
@end

@implementation YGCardContainerView

- (instancetype)init{
    if (self = [super init]){
        [self setUpSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    CGFloat width = self.width-40;
    CGFloat height = self.height-20;
    
    self.topRect = CGRectMake(10, 20, width, height-20);
    self.bottomRect = CGRectMake(30, 10, width, height);
    for (int i = 0; i < 3; i++) {
        YGCardItemView *itemView = [[YGCardItemView alloc] initWithFrame:i == 2 ? self.topRect : self.bottomRect];
        itemView.userInteractionEnabled = i == 2;
        [self addSubview:itemView];
        
        TPWeakSelf
        itemView.switchBlock = ^(BOOL finish) {
            TPStrongSelfElseReturn
            [self resetSubViews:finish];
        };
    }
}

- (void)resetSubViews:(BOOL)finish{
    if (finish){
        UIView *topView = self.subviews.lastObject;
        topView.transform = CGAffineTransformMakeRotation(0);
        topView.frame = self.bottomRect;
        topView.userInteractionEnabled = NO;
        [self insertSubview:topView atIndex:0];
    }else{
        UIView *secondView = self.subviews[1];
        [UIView animateWithDuration:0.2 animations:^{
            secondView.frame = self.topRect;
            secondView.userInteractionEnabled = YES;
        }];
    }
}

@end

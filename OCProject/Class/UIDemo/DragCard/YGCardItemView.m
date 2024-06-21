//
//  YGCardItemView.m
//  OCProject
//
//  Created by 王祥伟 on 2024/6/19.
//

#import "YGCardItemView.h"

@interface YGCardItemView ()
@property (nonatomic, assign) CGPoint originCenter;
@end

@implementation YGCardItemView

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
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    panGesture.maximumNumberOfTouches = 1;
    [self addGestureRecognizer:panGesture];
}

- (void)layoutSubviews{
    self.originCenter = self.center;
}

- (void)panGesture:(UIPanGestureRecognizer *)gesture{
    CGPoint point = [gesture translationInView:self];

    switch (gesture.state) {
        case UIGestureRecognizerStateChanged:
        {
            self.center = CGPointMake(self.originCenter.x+point.x, self.originCenter.y+point.y);
            self.transform = CGAffineTransformMakeRotation(point.x/1000*M_PI_2);
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (fabs(point.x) > UIDevice.width*0.4) {
                if (self.switchBlock) self.switchBlock(NO);
                [UIView animateWithDuration:0.2 animations:^{
                    CGFloat x = self.originCenter.x + point.x + (point.x > 0 ? UIDevice.width : -UIDevice.width);
                    CGFloat y = self.originCenter.y+point.y;
                    self.transform = CGAffineTransformTranslate(self.transform, x, y);
                } completion:^(BOOL finished) {
                    if (self.switchBlock) self.switchBlock(YES);
                }];
            }else{
                
                self.transform = CGAffineTransformMakeRotation(0);
                self.center = self.originCenter;
            }
        }
            break;
        default:
            break;
    }
}

@end

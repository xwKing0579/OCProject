//
//  FPSLabel.m
//  learning
//
//  Created by 祥伟 on 2018/7/25.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "FPSLabel.h"

@implementation FPSLabel
{
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
}

- (instancetype)init{
    if (self = [super init]) {
        [self setUpSubView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpSubView];
    }
    
    return self;
}

- (void)setUpSubView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (self.frame.size.width < 60 || self.frame.size.height < 20) {
            self.size = CGSizeMake(60, 20);
        }
        
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.font = [UIFont systemFontOfSize:14];
        
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    });
}



- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    
    CGFloat progress = fps / 60.0;
    self.textColor = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    self.text = [NSString stringWithFormat:@"PFS:%d",(int)round(fps)];
}

- (void)dealloc {
    [_link invalidate];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [_link invalidate];
    }
}

@end

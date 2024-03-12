//
//  TPOperation.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/11.
//

#import "TPOperation.h"

@implementation TPOperation
@synthesize finished = _finished;
@synthesize executing = _executing;

- (void)start{
    if ([self isCancelled]) {
        self.finished = YES;
        return;
    }
    self.executing = YES;
    !self.model.block ?: self.model.block(self, self.model);
}

- (void)setExecuting:(BOOL)executing{
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinished:(BOOL)finished{
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

@end

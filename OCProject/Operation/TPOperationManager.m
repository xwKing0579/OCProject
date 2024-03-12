//
//  TPOperationManager.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/11.
//

#import "TPOperationManager.h"
#import "TPOperation.h"

@interface TPOperationManager ()
@property (nonatomic, strong) NSOperationQueue *taskQueue;
@property (nonatomic, strong) NSMutableDictionary *objectPtrs;
@end

@implementation TPOperationManager

+ (instancetype)sharedManager {
    static TPOperationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}

+ (void)addOperationModel:(TPOperationModel *)model{
    if (!model.subView) return;
    TPOperationManager *manager = [TPOperationManager sharedManager];
    NSString *key = [NSString stringWithFormat:@"%ld",(uintptr_t)model.subView];
    
    TPOperation *operation = [[TPOperation alloc] init];
    operation.model = model;
    operation.queuePriority = model.priority;
    [manager.taskQueue addOperation:operation];
    [manager.objectPtrs setValue:operation forKey:key];
}

+ (void)removeOperationForView:(UIView *)view{
    if (!view) return;
    TPOperationManager *manager = [TPOperationManager sharedManager];
    NSString *key = [NSString stringWithFormat:@"%ld",(uintptr_t)view];
    
    if ([manager.objectPtrs valueForKey:key]){
        TPOperation *operation = manager.objectPtrs[key];
        operation.isExecuting ? operation.finished = YES : [operation cancel];
        operation = nil;
        [manager.objectPtrs removeObjectForKey:key];
    }
}

+ (void)removeAllOperation{
    TPOperationManager *manager = [TPOperationManager sharedManager];
    for (NSString *key in manager.objectPtrs.allKeys) {
        TPOperation *operation = manager.objectPtrs[key];
        operation.isExecuting ? operation.finished = YES : [operation cancel];
        operation = nil;
        [manager.objectPtrs removeObjectForKey:key];
    }
}

- (NSMutableDictionary *)objectPtrs{
    if (!_objectPtrs){
        _objectPtrs = [[NSMutableDictionary alloc] init];
    }
    return _objectPtrs;
}

- (NSOperationQueue *)taskQueue{
    if (!_taskQueue){
        _taskQueue = [[NSOperationQueue alloc] init];
        _taskQueue.maxConcurrentOperationCount = 1;
    }
    return _taskQueue;
}

@end

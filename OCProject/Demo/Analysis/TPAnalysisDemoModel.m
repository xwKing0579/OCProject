//
//  TPAnalysisDemoModel.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/10.
//

#import "TPAnalysisDemoModel.h"

@implementation TPAnalysisDemoModel

+ (NSArray <TPAnalysisDemoModel *>*)data{
    NSMutableArray *data = [NSMutableArray array];
    for (int i = 0; i < 99; i++) {
        NSString *idString = [NSString stringWithFormat:@"20240110%02d",i];
        NSString *labelString = [NSString stringWithFormat:@"click label%02d",i];
        NSString *buttonString = [NSString stringWithFormat:@"click button%02d",i];
        NSString *controlString = [NSString stringWithFormat:@"click control%02d",i];
        [data addObject:@{@"id":idString,@"labelString":labelString,@"buttonString":buttonString,@"controlString":controlString}];
    }
    return [NSArray yy_modelArrayWithClass:[self class] json:data];
}

@end

//
//  TPTinyPngManger.m
//  OCProject
//
//  Created by 王祥伟 on 2024/6/24.
//

#import "TPTinyPngManger.h"

@implementation TPTinyPngManger

+ (void)tingPngCompress:(NSData *)imageData{
    NSString *apiKey = @"YXBpOmFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6MDEyMzQ1";
    NSString *url = @"https://api.tinify.com/shrink";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"api:%@", apiKey] forHTTPHeaderField:@"Authorization"];
    
    NSString *base64ImageData = [NSString stringWithFormat:@"%@",[imageData base64EncodedStringWithOptions:0]];
    [manager POST:url parameters:@{@"source":base64ImageData} headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end

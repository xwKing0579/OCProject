//
//  TPNetworkManager.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "TPNetworkManager.h"
#import <AFNetworking.h>
#import "TPCryptoUtils.h"
@implementation TPNetworkManager

+ (void)initialize{
    [self managerConfig];
}

+ (AFHTTPSessionManager *)manager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
    });
    return manager;
}

+ (NSString *)fullUrl:(NSString *)url{
    if ([url hasPrefix:@"/"]) url = [url substringFromIndex:1];
    return [NSString stringWithFormat:@"%@/%@",[self baseUrl],url];
}

+ (NSString *)baseUrl{return @"";}

+ (void)managerConfig{}

+ (__kindof NSURLSessionTask *)get:(NSString *)url
                            params:(id _Nullable)params
                           success:(TPHTTPRequestSuccess)success
                           failure:(TPHTTPRequestFailed)failure{
    return [self get:url params:params success:success failure:failure responseCache:nil];
}

+ (__kindof NSURLSessionTask *)get:(NSString *)url
                            params:(id _Nullable)params
                           success:(TPHTTPRequestSuccess)success
                           failure:(TPHTTPRequestFailed)failure
                     responseCache:(TPHTTPRequestCache _Nullable)responseCache{
    responseCache == nil ? nil : responseCache([TPNetworkCache httpCacheForURL:url params:params]);
    return [self.manager GET:[self fullUrl:url] parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success ? success(responseObject) : nil;
        responseCache == nil ? nil : [TPNetworkCache setHttpCache:responseObject URL:url params:params];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure((int)error.code,[self errorMessage:error]) : nil;
    }];
}

+ (__kindof NSURLSessionTask *)post:(NSString *)url
                             params:(id _Nullable)params
                            success:(TPHTTPRequestSuccess)success
                            failure:(TPHTTPRequestFailed)failure{
    return [self post:url params:params success:success failure:failure responseCache:nil];
}

+ (__kindof NSURLSessionTask *)post:(NSString *)url
                             params:(id _Nullable)params
                            success:(TPHTTPRequestSuccess)success
                            failure:(TPHTTPRequestFailed)failure
                      responseCache:(TPHTTPRequestCache _Nullable)responseCache{
    responseCache == nil ? nil : responseCache([TPNetworkCache httpCacheForURL:url params:params]);
    return [self.manager POST:[self fullUrl:url] parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success ? success(responseObject) : nil;
        responseCache == nil ? nil : [TPNetworkCache setHttpCache:responseObject URL:url params:params];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure((int)error.code,[self errorMessage:error]) : nil;
    }];
}

+ (__kindof NSURLSessionTask *)uploadImagesWithURL:(NSString *)url
                                            params:(id _Nullable)params
                                              name:(NSString *)name
                                            images:(NSArray<UIImage *> *)images
                                         fileNames:(NSArray<NSString *> *)fileNames
                                        imageScale:(CGFloat)imageScale
                                         imageType:(NSString *)imageType
                                          progress:(TPHTTPProgress)progress
                                           success:(TPHTTPRequestSuccess)success
                                           failure:(TPHTTPRequestFailed)failure{
    return [self.manager POST:[self fullUrl:url] parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            // 默认图片的文件名, 若fileNames为nil就使用
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = [NSString stringWithFormat:@"%@%ld.%@",str,i,imageType?:@"jpg"];
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? [NSString stringWithFormat:@"%@.%@",fileNames[i],imageType?:@"jpg"] : imageFileName
                                    mimeType:[NSString stringWithFormat:@"image/%@",imageType ?: @"jpg"]];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure((int)error.code,[self errorMessage:error]) : nil;
    }];
}

+ (__kindof NSURLSessionTask *)downloadWithURL:(NSString *)url
                                       fileDir:(NSString *)fileDir
                                      progress:(TPHTTPProgress)progress
                                       success:(void(^)(NSString *filePath))success
                                       failure:(TPHTTPRequestFailed)failure{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self fullUrl:url]]];
    return [self.manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            failure ? failure((int)error.code,[self errorMessage:error]) : nil;
        }else{
            success ? success(filePath.absoluteString) : nil;
        }
    }];
}

+ (NSString *)errorMessage:(NSError *)error{
    return [error description];
}

@end

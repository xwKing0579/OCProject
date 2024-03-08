//
//  TPNetworkManager.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN
@class AFHTTPSessionManager;

typedef void(^TPHTTPRequestSuccess)(id responseObject);
typedef void(^TPHTTPRequestFailed)(int code, NSString *msg);
typedef void(^TPHTTPRequestCache)(id responseCache);
typedef void(^TPHTTPProgress)(NSProgress *progress);

@interface TPNetworkManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *managers;

+ (__kindof NSURLSessionTask *)get:(NSString *)url
                            params:(id _Nullable)params
                           success:(TPHTTPRequestSuccess)success
                           failure:(TPHTTPRequestFailed)failure;

+ (__kindof NSURLSessionTask *)get:(NSString *)url
                            params:(id _Nullable)params
                           success:(TPHTTPRequestSuccess)success
                           failure:(TPHTTPRequestFailed)failure
                     responseCache:(TPHTTPRequestCache _Nullable)responseCache;

+ (__kindof NSURLSessionTask *)post:(NSString *)url
                             params:(id _Nullable)params
                            success:(TPHTTPRequestSuccess)success
                            failure:(TPHTTPRequestFailed)failure;

+ (__kindof NSURLSessionTask *)post:(NSString *)url
                             params:(id _Nullable)params
                            success:(TPHTTPRequestSuccess)success
                            failure:(TPHTTPRequestFailed)failure
                      responseCache:(TPHTTPRequestCache _Nullable)responseCache;

+ (__kindof NSURLSessionTask *)uploadImagesWithURL:(NSString *)url
                                            params:(id _Nullable)params
                                              name:(NSString *)name
                                            images:(NSArray<UIImage *> *)images
                                         fileNames:(NSArray<NSString *> *)fileNames
                                        imageScale:(CGFloat)imageScale
                                         imageType:(NSString *)imageType
                                          progress:(TPHTTPProgress)progress
                                           success:(TPHTTPRequestSuccess)success
                                           failure:(TPHTTPRequestFailed)failure;

+ (__kindof NSURLSessionTask *)downloadWithURL:(NSString *)url
                                       fileDir:(NSString *)fileDir
                                      progress:(TPHTTPProgress)progress
                                       success:(void(^)(NSString *filePath))success
                                       failure:(TPHTTPRequestFailed)failure;

+ (NSString *)baseUrl;
+ (void)managerConfig;
+ (AFHTTPSessionManager *)manager;
@end

NS_ASSUME_NONNULL_END

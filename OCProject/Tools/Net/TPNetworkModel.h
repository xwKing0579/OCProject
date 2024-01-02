//
//  TPNetworkModel.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPNetworkModel : NSObject


@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSData *httpBody;
@property (nonatomic, copy) NSString *httpMethod;
@property (nonatomic, copy) NSString *mimeType;

@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, strong) NSString *data;

@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, assign) double totalDuration;

@property (nonatomic, copy) NSString *suggestedFilename;
@property (nonatomic, assign) long long expectedContentLength;

@property (nonatomic, copy) NSDictionary *resquestHeaderFields;
@property (nonatomic, copy) NSDictionary *responseHeaderFields;
@end

NS_ASSUME_NONNULL_END

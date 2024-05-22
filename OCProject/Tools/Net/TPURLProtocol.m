//
//  TPURLProtocol.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/29.
//

#import "TPURLProtocol.h"
#import "TPNetworkModel.h"

static NSMutableArray *networkData;
NSString *const kTPURLProtocolKey = @"kTPURLProtocolKey";

@interface TPURLProtocol ()<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSURLConnection *task;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@end

@implementation TPURLProtocol
#ifdef DEBUG
- (void)startLoading{
    self.startDate = NSDate.new;
    NSURLRequest *request = [[self class] canonicalRequestForRequest:self.request];
    self.task = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (void)stopLoading{
    [self.task cancel];
    self.endDate = NSDate.new;
    
    ///常驻线程，是否存在多线程->需要加锁
    NSURLRequest *request = self.request;
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)self.response;
    
    TPNetworkModel *model = [TPNetworkModel new];
    model.url = request.URL.absoluteString;
    model.httpBody = request.HTTPBody;
    model.httpMethod = request.HTTPMethod;
    model.resquestHeaderFields = request.allHTTPHeaderFields;
    model.startTime = self.startDate.toString;
    
    NSDictionary *params = [self requstParams:request];
    NSMutableString *result = [NSMutableString string];
    NSArray *keys = params.allKeys;
    for (NSString *key in keys) {
        if ([keys.lastObject isEqualToString:key]){
            [result appendString:[NSString stringWithFormat:@"%@ = %@",key,params[key]]];
        }else{
            [result appendString:[NSString stringWithFormat:@"%@ = %@\n",key,params[key]]];
        }
    }
    model.requestParams = result;
   
    model.data = [NSString convertJsonFromData:self.data];
    model.mimeType = response.MIMEType;
    model.statusCode = response.statusCode;
    model.suggestedFilename = response.suggestedFilename;
    model.expectedContentLength = response.expectedContentLength;
    model.responseHeaderFields = response.allHeaderFields;
    model.endTime = self.endDate.toString;
    
    model.totalDuration = [self.endDate timeIntervalSince1970] - [self.startDate timeIntervalSince1970];
    if (!networkData) networkData = [NSMutableArray array];
    [networkData insertObject:model atIndex:0];
}

- (NSDictionary *)requstParams:(NSURLRequest *)request{
    NSDictionary *parameters;
    if ([request.HTTPMethod isEqualToString:@"GET"]){
        NSURLComponents *compents = [[NSURLComponents alloc] initWithURL:[NSURL URLWithString:request.URL.absoluteString] resolvingAgainstBaseURL:NO];
        NSMutableDictionary *item = [NSMutableDictionary dictionary];
        for (NSURLQueryItem *queryItem in compents.queryItems) {
            if (queryItem.value && queryItem.name) [item setValue:queryItem.value forKey:queryItem.name];
        }
        parameters = item;
    }else{
        if (request.HTTPBody){
            parameters = [NSJSONSerialization JSONObjectWithData:request.HTTPBody options:0 error:nil];
        }else{
            if (![request.HTTPBodyStream isKindOfClass:NSClassFromString(@"AFMultipartBodyStream")]) {
                NSUInteger lenght = [[request.allHTTPHeaderFields objectForKey:@"Content-Length"] integerValue];
                if (lenght > 0 && lenght < 20 * 1024 * 1024) {
                    
                    NSInputStream * stream =  self.request.HTTPBodyStream;//[self.request.HTTPBodyStream copy];
                    [stream open];
                    NSMutableData * tempData = [NSMutableData data];
                    
                    while (YES) {
                        uint8_t buffer[lenght];
                        unsigned int numBytes;
                        if(stream.hasBytesAvailable)
                        {
                            numBytes = [stream read:buffer maxLength:lenght];
                            if (numBytes > 0) {
                                [tempData appendData:[NSData dataWithBytes:buffer length:numBytes]];
                            }
                            if (tempData.length == lenght) {
                                [stream close];
                                break;
                            }
                        }
                    }
                    parameters = [NSJSONSerialization JSONObjectWithData:tempData options:0 error:nil];
                }
            }
        }
    }
    return parameters;
}

+ (NSArray <TPNetworkModel *>*)data{
    return networkData ?: @[];
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request{
    if (![request.URL.scheme isEqualToString:@"http"]
        && ![request.URL.scheme isEqualToString:@"https"]) {
        return NO;
    }
    // 如果是已经拦截过，放行
    if ([NSURLProtocol propertyForKey:kTPURLProtocolKey inRequest:request]) {
        return NO;
    }
    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request{
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    NSString *host = request.URL.host;
    
    // HTTPDNS 直连 iP，host 帮助运营商解析
    if (host) {
       [mutableRequest setValue:host forHTTPHeaderField:@"HOST"];
    }
    // HTTPDNS 域名转 iP
    [NSURLProtocol setProperty:@(YES) forKey:kTPURLProtocolKey inRequest:mutableRequest];
    return [mutableRequest copy];
}

#pragma mark - NSURLConnectionDelegate
- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection {
    return YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    [self.client URLProtocol:self didReceiveAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    [self.client URLProtocol:self didCancelAuthenticationChallenge:challenge];
}

#pragma mark - NSURLConnectionDataDelegate
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    if (response) {
        self.response = response;
        [self.client URLProtocol:self wasRedirectedToRequest:request redirectResponse:response];
    }
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    self.response = response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
    [self.data appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[self client] URLProtocolDidFinishLoading:self];
}

- (NSMutableData *)data{
    if (!_data){
        _data = [NSMutableData data];
    }
    return _data;
}
#endif
@end

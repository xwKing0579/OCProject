//
//  TPNetworkManager+Envi.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/6.
//

#import "TPNetworkManager+Envi.h"
#import "TPEnviConfig.h"

@implementation TPNetworkManager (Envi)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
+ (NSString *)baseUrl{
#ifdef DEBUG
    TPSchemeEnvi envi = [TPEnviConfig envi];
    if (envi == TPSchemeEnviDev) {
        return @"https://ecloudsit.tppension.cntaiping.com";
    }else if (envi == TPSchemeEnviPreRelese){
        return @"https://ecloudsit.tppension.cntaiping.com";
    }else if (envi == TPSchemeEnviRelese){
        return @"https://ecloudsit.tppension.cntaiping.com";
    }
#endif
    return @"https://ecloudsit.tppension.cntaiping.com";
}
#pragma clang diagnostic pop
@end

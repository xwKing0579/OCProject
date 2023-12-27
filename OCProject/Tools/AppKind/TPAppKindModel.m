//
//  TPAppKindModel.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/22.
//

#import "TPAppKindModel.h"

@implementation TPAppKindModel

#ifdef DEBUG
+ (void)sysetmAppList:(TPAppListBlock)block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        NSMutableArray *appList = [NSMutableArray array];
        
        id space = [NSObject performTarget:@"LSApplicationWorkspace_Class" action:@"defaultWorkspace"];
        SEL sel = NSSelectorFromString(@"installedPlugins");
        if (![space respondsToSelector:sel]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(appList);
            });
            return;
        }
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSArray *plugins = [space performSelector:sel];
        SEL appSel = NSSelectorFromString(@"containingBundle");
        for (id plugin in plugins) {
            if ([plugin respondsToSelector:appSel]){
                id bundle = [plugin performSelector:appSel];
                if (bundle) {
                    TPAppKindModel *model = [TPAppKindModel new];
                    unsigned int outCount = 0;
                    objc_property_t *properties = class_copyPropertyList(TPAppKindModel.class , &outCount);
                    for (int i = 0; i < outCount; i++) {
                        objc_property_t property = properties[i];
                        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
                        SEL bundleSel = NSSelectorFromString(key);
                        if ([bundle respondsToSelector:bundleSel]){
                            if ([bundle performSelector:bundleSel]){
                                NSString *vaule = [NSString stringWithFormat:@"%@",[bundle performSelector:bundleSel]];
                                [model setValue:vaule forKey:key];
                            }
                        }
                    }
                    free(properties);
                    [appList addObject:model];
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(appList);
        });
#pragma clang diagnostic pop
    });
}
#endif

@end

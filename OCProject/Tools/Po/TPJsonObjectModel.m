//
//  TPJsonObjectModel.m
//  FXTP
//
//  Created by 王祥伟 on 2024/6/4.
//

#import "TPJsonObjectModel.h"

@implementation TPJsonObjectModel
+ (void)toJson:(NSObject *)obj{
    if (obj && ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]])){
        [TPRouter jumpUrl:TPString.vc_json_object params:@{@"obj":obj}];
        return;
    }
    UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
    NSString *content = pastboard.string.whitespace;
    if (content.length == 0) [TPToastManager showText:@"请复制后再解析"];
  
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
      
    if (error) {
        [TPToastManager showText:@"解析失败"];
    }
    
    if (jsonObject) [TPRouter jumpUrl:TPString.vc_json_object params:@{@"obj":jsonObject}];
}
@end

//
//  TPString.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/14.
//

#import "TPString.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation TPString
#pragma clang diagnostic pop

+ (NSString *)prefix_app{ return @"TP"; }
+ (NSString *)prefix_viewController{ return @"vc_"; }
+ (NSString *)suffix_viewController{ return @"ViewController"; }
+ (NSString *)prefix_tableViewCell{ return @"tc_"; }
+ (NSString *)suffix_tableViewCell{ return @"TableViewCell"; }

+ (NSString *)vc_base_tabbar{ return @"TPBaseTabBarController"; }
+ (NSString *)vc_base_navigation{ return @"TPBaseNavigationController"; };
+ (NSString *)vc_pop_views{ return @"TPPopViewsController"; };
+ (NSString *)vc_i_carousel{ return @"TPiCarouselViewController"; };
+ (NSString *)vc_tabbar{ return @"TPTabBarController"; };

+ (NSSet *)routerSet{
    return [[NSSet alloc] initWithObjects:[self vc_home],[self vc_ui],[self vc_mine],[self vc_web], 
            [self vc_router_params], [self vc_home], nil];
}
+ (BOOL)resolveClassMethod:(SEL)selector{
    RESOLVE_CLASS_METHOD([NSStringFromSelector(selector) hasPrefix:self.prefix_tableViewCell], @selector(string_tableViewCell))
    RESOLVE_CLASS_METHOD([NSStringFromSelector(selector) hasPrefix:self.prefix_viewController], @selector(string_viewController))
    RESOLVE_CLASS_METHOD([NSStringFromSelector(selector) hasPrefix:[self.prefix_app lowercaseString]], @selector(string_selector))
    RESOLVE_CLASS_METHOD(NSStringFromSelector(selector).length, @selector(string_selector_unknow))
    return [super resolveClassMethod:selector];
}

+ (NSString *)string_tableViewCell{
    NSArray <NSString *>*names = [NSStringFromSelector(_cmd) componentsSeparatedByString:@"_"];
    NSString *cellString = self.prefix_app;
    for (int i = 1; i < names.count; i++) {
        cellString = [cellString stringByAppendingString:names[i].prefixCapital];
    }
    return [NSString stringWithFormat:@"%@%@",cellString,self.suffix_tableViewCell];
}

+ (NSString *)string_viewController{
    NSArray <NSString *>*names = [NSStringFromSelector(_cmd) componentsSeparatedByString:@"_"];
    NSString *cellString = self.prefix_app;
    for (int i = 1; i < names.count; i++) {
        cellString = [cellString stringByAppendingString:names[i].prefixCapital];
    }
    return [NSString stringWithFormat:@"%@%@",cellString,self.suffix_viewController];
}

+ (NSString *)string_selector{
    NSArray <NSString *>*names = [NSStringFromSelector(_cmd) componentsSeparatedByString:@"_"];
    NSString *cellString = self.prefix_app;
    for (int i = 1; i < names.count; i++) {
        cellString = [cellString stringByAppendingString:names[i].prefixCapital];
    }
    return cellString;
}

+ (NSString *)string_selector_unknow{
    return NSStringFromSelector(_cmd);
}

@end

@implementation NSString (SelectorName)

- (Class)toClass{
    return NSClassFromString(self);
}

- (NSString *)prefixCapital{
    if (self.length){
        return [self stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[self substringToIndex:1] capitalizedString]];
    }
    return self;
}

- (NSString *)abbr{
    NSString *temp = self;
    NSString *prefix = [TPString.prefix_app uppercaseString];
    NSString *suffix = TPString.suffix_viewController;
    if ([temp hasPrefix:prefix]){
        temp = [temp stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:@""];
    }
    if ([temp hasSuffix:suffix]){
        temp = [temp stringByReplacingCharactersInRange:NSMakeRange(temp.length-suffix.length, suffix.length) withString:@""];
    }
    return convertStringToSnakeCase(temp);
}

NSString *convertStringToSnakeCase(NSString *input) {
    for (int i = 0; i < input.length; i++) {
        unichar currentChar = [input characterAtIndex:i];
        if (currentChar >= 'A' && currentChar <= 'Z'){
            NSString *lowString = [NSString stringWithFormat:@"_%c", tolower(currentChar)];
            if (i == 0 || i == input.length - 1){
                lowString = [lowString substringFromIndex:1];
            }
            input = [input stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:lowString];
        }
    }
    return input;
}

@end

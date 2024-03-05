//
//  TPMineViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "TPMineViewController.h"

@interface TPMineViewController ()

@end

@implementation TPMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"目录";

    if (self.data.count == 0) {
        NSMutableArray *data = [NSMutableArray array];
        unsigned int count;
        NSString *string = @"TPMineModel";
        Class class = NSClassFromString(string);
        Class metacls = objc_getMetaClass(string.UTF8String);
        Method *methods = class_copyMethodList(metacls, &count);
        for (int i = 0; i < count; i++) {
            NSString *methodString = [NSString stringWithUTF8String:sel_getName(method_getName(methods[i]))];
            id result = [class performAction:methodString];
            if ([result isKindOfClass:[NSArray class]] ||
                [result isKindOfClass:[NSString class]]){
                [data addObject:@{methodString:result}];
            }
        }
        self.data = data;
    }
}

- (NSString *)cellClass{
    return @"TPMineTableViewCell_Class";
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id object = self.data[indexPath.row];
    
    if ([object isKindOfClass:[NSDictionary class]]){
        id value = ((NSDictionary *)object).allValues.firstObject;
        if ([value isKindOfClass:[NSString class]]) {
            [TPRouter jumpUrl:[NSString stringWithFormat:@"%@?url=%@",TPRouter.web,value]];
        }else if ([value isKindOfClass:[NSArray class]] && ((NSArray *)value).count == 1){
            [TPRouter jumpUrl:[NSString stringWithFormat:@"%@?url=%@",TPRouter.web,((NSArray *)value)[0]]];
        }else{
            [TPRouter jumpUrl:TPRouter.mine params:@{@"data":value}];
        }
    }else if ([object isKindOfClass:[NSString class]]){
        [TPRouter jumpUrl:[NSString stringWithFormat:@"%@?url=%@",TPRouter.web,object]];
    }
}

@end

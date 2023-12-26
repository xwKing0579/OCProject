//
//  TPUIHierarchyModel.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPUIHierarchyModel : NSObject
@property (nonatomic, assign) int deepLevel;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL haveSubviews;
@property (nonatomic, assign) BOOL isController;
@property (nonatomic, copy) NSString *objectClass;
@property (nonatomic, assign) unsigned long objectPtr;

@property (nonatomic, strong) NSArray <TPUIHierarchyModel *>*subviews;

@end

NS_ASSUME_NONNULL_END

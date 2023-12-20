//
//  TPCrashModel.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/12.
//

#import "TPCrashModel.h"
#import <objc/runtime.h>

@implementation TPCrashModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
   unsigned int count = 0;
   Ivar * ivars = class_copyIvarList([self class], &count);
   for (int i = 0; i < count; i++) {
       Ivar ivar = ivars[i];
       const char * name = ivar_getName(ivar);
       NSString * key = [NSString stringWithUTF8String:name];
       id value = [self valueForKey:key];
       [aCoder encodeObject:value forKey:key];
   }
   free(ivars);
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
   if (self) {
       unsigned int count = 0;
       Ivar * ivars =  class_copyIvarList([self class], &count);
       for (int i = 0 ; i < count; i++) {
           Ivar ivar = ivars[i];
           const char * name = ivar_getName(ivar);
           NSString * key = [NSString stringWithUTF8String:name];
           id value = [aDecoder decodeObjectForKey:key];
           [self setValue:value forKey:key];
       }
       free(ivars);
   }
   return self;
}

@end

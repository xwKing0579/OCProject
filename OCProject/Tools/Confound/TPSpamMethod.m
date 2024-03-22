//
//  TPSpamMethod.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/21.
//

#import "TPSpamMethod.h"
NSString *const kSpamMethodPrefixName = @"tp_";
@implementation TPSpamMethod

+ (void)spamCodeProjectPath:(NSString *)projectPath{
    return [self spamCodeProjectPath:projectPath ignoreDirNames:nil];
}

+ (void)spamCodeProjectPath:(NSString *)projectPath ignoreDirNames:(NSArray<NSString *> * __nullable)ignoreDirNames{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray<NSString *> *files = [fm contentsOfDirectoryAtPath:projectPath error:nil];
    for (NSString *filePath in files) {
        if ([ignoreDirNames containsObject:filePath]) continue;
        NSString *path = [projectPath stringByAppendingPathComponent:filePath];
        
        BOOL isDirectory;
        if ([fm fileExistsAtPath:path isDirectory:&isDirectory] && isDirectory) {
            [self spamCodeProjectPath:path ignoreDirNames:ignoreDirNames];
            continue;
        }
        
        NSString *fileName = filePath.lastPathComponent;
        if ([fileName hasSuffix:@".h"]) {
            if ([fileName containsString:@"+"]) continue;
            if ([fileName isEqualToString:NSStringFromClass([self class])]) continue;
            NSString *headName = fileName.stringByDeletingPathExtension;
            NSString *mFileName = [headName stringByAppendingPathExtension:@"m"];
            if (![files containsObject:mFileName]) continue;
            
            NSString *mfile = [path stringByReplacingOccurrencesOfString:@".h" withString:@".m"];
            NSSet *mehods = [self alreadyMethodRename:headName];
            int count = (int)MAX(1, MIN(20, mehods.count));
            NSArray *customMethods = [self randomMethodName:mfile count:count];
            [self createSpamMethods:customMethods toFilePath:[path stringByReplacingOccurrencesOfString:@".h" withString:@""]];
        }
    }
}

+ (NSSet *)alreadyMethodRename:(NSString *)className{
    NSMutableSet *set = [NSMutableSet set];
    NSArray *component = [className componentsSeparatedByString:@"+"];
    NSString *classString = [component.firstObject stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    Class cls = NSClassFromString(classString);
    if (!cls) return set;
    
    unsigned int classCount;
    Class metacls = objc_getMetaClass(classString.UTF8String);
    Method *methods = class_copyMethodList(metacls, &classCount);
    for (int i = 0; i < classCount; i++) {
        NSString *methodString = [NSString stringWithUTF8String:sel_getName(method_getName(methods[i]))];
        [set addObject:methodString];
    }
    if (methods) free(methods);
    
    unsigned int instanceCount;
    Method *instanceMethods = class_copyMethodList(cls, &instanceCount);
    for (int i = 0; i < instanceCount; i++) {
        NSString *methodString = [NSString stringWithUTF8String:sel_getName(method_getName(instanceMethods[i]))];
        [set addObject:methodString];
    }
    if (instanceMethods) free(instanceMethods);
    return set;
}

+ (void)createSpamMethods:(NSArray *)methods toFilePath:(NSString *)filePath{
    NSError *error = nil;
    NSString *hfilePath = [NSString stringWithFormat:@"%@.h",filePath];
    NSString *mfilePath = [NSString stringWithFormat:@"%@.m",filePath];
    NSMutableString *hfileContent = [NSMutableString stringWithContentsOfFile:hfilePath encoding:NSUTF8StringEncoding error:&error];
    NSMutableString *mfileContent = [NSMutableString stringWithContentsOfFile:mfilePath encoding:NSUTF8StringEncoding error:&error];
    NSArray *hcomponent = [hfileContent componentsSeparatedByString:@"@end"];
    NSArray *mcomponent = [mfileContent componentsSeparatedByString:@"@end"];
    if (hcomponent.count < 2 || mcomponent.count < 2) return;
    
    NSMutableString *hmethodContent = [NSMutableString string];
    NSMutableString *mmethodContent = [NSMutableString string];
    for (NSString *string in methods) {
        [hmethodContent appendString:string];
        [hmethodContent appendString:@";\n"];
        
        [mmethodContent appendString:string];
        [mmethodContent appendString:@"{\n    return NSStringFromSelector(_cmd);\n}\n\n"];
    }
    NSMutableString *hContent = [NSMutableString string];
    NSMutableString *mContent = [NSMutableString string];
    for (int i = 0; i < hcomponent.count-1; i++) {
        NSString *hString = [hcomponent[i] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        if ([hString containsString:@"@interface"]){
            [hContent appendString:hString];
            [hContent appendString:@"\n\n"];
            [hContent appendString:hmethodContent];
        }else{
            [hContent appendString:hcomponent[i]];
        }
        [hContent appendString:@"@end"];
    }
    
    for (int i = 0; i < mcomponent.count-1; i++) {
        NSString *mString = [mcomponent[i] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        if ([mString containsString:@"@implementation"]){
            [mContent appendString:mString];
            [mContent appendString:@"\n\n"];
            [mContent appendString:mmethodContent];
        }else{
            [mContent appendString:mcomponent[i]];
        }
        [mContent appendString:@"@end"];
    }
    
    [hContent appendString:hcomponent.lastObject];
    [mContent appendString:mcomponent.lastObject];
    [hContent writeToFile:hfilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [mContent writeToFile:mfilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (NSArray *)randomMethodName:(NSString *)path count:(int)count{
    NSSet *words = [self customWordsInPath:path];
    NSArray *wordsValue = words.allObjects;
    
    int lenth = arc4random()%3+3;
    NSMutableSet *indexs = [NSMutableSet set];
    NSMutableSet *result = [NSMutableSet set];
    while (result.count < count) {
        while (indexs.count < lenth) {
            [indexs addObject:[NSNumber numberWithInt:arc4random()%words.count]];
        }
        NSString *methodString = @"";
        for (int i = 0; i < indexs.count;i++) {
            int index = [indexs.allObjects[i] intValue];
            NSString *wordString = wordsValue[index];
            if (i != 0) wordString = [wordString capitalizedString];
            methodString = [methodString stringByAppendingString:wordString];
        }
        [result addObject:methodString];
        [indexs removeAllObjects];
    }
    NSMutableArray *mehods = [NSMutableArray array];
    for (NSString *string in result.allObjects) {
        NSString *methodString = [NSString stringWithFormat:@"%@ (NSString *)%@",self.randomMethodType,string];
        [mehods addObject:methodString];
    }
    return mehods;
}

+ (NSSet *)customWordsInPath:(NSString *)path{
    NSError *error = nil;
    NSMutableString *fileContent = [NSMutableString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSArray *words = [fileContent componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableDictionary *wordCounts = [NSMutableDictionary dictionary];
    for (NSString *word in words) {
        if (word.length > 0) {
            NSNumber *count = wordCounts[word];
            if (count) {
                wordCounts[word] = @(count.intValue + 1);
            } else {
                wordCounts[word] = @1;
            }
        }
    }
    NSArray *sortedWords = [wordCounts keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj2 compare:obj1];
    }];

    NSMutableSet *result = [NSMutableSet set];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[A-Za-z]+$"];
    for (NSString *word in sortedWords) {
        if ([predicate evaluateWithObject:word] && word.length > 2 && word.length < 10) [result addObject:[word lowercaseString]];
    }
    NSSet *supple = [NSSet setWithArray:@[@"copy",@"alloc",@"with",@"value",@"manager",@"viewContoller",@"model",@"string",@"array",@"dictionary",@"mute",@"object",@"text",@"title",@"content",@"textView",@"textFiled",@"font",@"color",@"navigation",@"tabbar",@"device",@"toast",@"alert",@"router",@"path",@"file",@"height",@"size",@"window",@"delegate",@"protocol",@"empty",@"cache",@"refresh",@"image",@"word",@"setting",@"safe"]];
    for (NSString *string in [supple allObjects]) {
        if (![result containsObject:string]) [result addObject:string];
    }
    [result removeObject:@"void"];
    return result;
}

+ (NSString *)randomMethodType{
    return  arc4random() % 2 == 1 ? @"-" : @"+";
}

+ (NSString *)methodPrefix{
    return kSpamMethodPrefixName;
}
@end

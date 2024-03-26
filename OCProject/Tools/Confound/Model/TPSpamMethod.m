//
//  TPSpamMethod.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/21.
//

#import "TPSpamMethod.h"
#import "TPConfoundSetting.h"
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
            NSString *headName = fileName.stringByDeletingPathExtension;
            if ([headName isEqualToString:NSStringFromClass([self class])]) continue;
            NSString *mFileName = [headName stringByAppendingPathExtension:@"m"];
            if (![files containsObject:mFileName]) continue;
            
            NSString *mfile = [path stringByReplacingOccurrencesOfString:@".h" withString:@".m"];
            NSArray *mehods = [self alreadyMethodRename:mfile];
            int count = (int)(MIN(20, mehods.count) + arc4random()%4);
            NSArray *customMethods = [self randomMethodName:mfile count:count];
            [self createSpamMethods:customMethods toFilePath:[path stringByReplacingOccurrencesOfString:@".h" withString:@""]];
        }
    }
}

+ (NSArray *)alreadyMethodRename:(NSString *)path{
    NSError *error = nil;
    NSMutableString *fileContent = [NSMutableString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSArray *contain = [fileContent subStartStr:@"(void)" endStr:@";"];
    return contain;
}

+ (void)createSpamMethods:(NSArray *)methods toFilePath:(NSString *)filePath{
    NSError *error = nil;
    NSString *hfilePath = [NSString stringWithFormat:@"%@.h",filePath];
    NSString *mfilePath = [NSString stringWithFormat:@"%@.m",filePath];
    NSMutableString *hfileContent = [NSMutableString stringWithContentsOfFile:hfilePath encoding:NSUTF8StringEncoding error:&error];
    NSMutableString *mfileContent = [NSMutableString stringWithContentsOfFile:mfilePath encoding:NSUTF8StringEncoding error:&error];
    if (error) return;
    NSArray *hcomponent = [hfileContent componentsSeparatedByString:@"@end"];
    NSArray *mcomponent = [mfileContent componentsSeparatedByString:@"@end"];
    if (hcomponent.count < 2 || mcomponent.count < 2) return;
    
    NSMutableString *hmethodContent = [NSMutableString string];
    NSMutableString *mmethodContent = [NSMutableString string];
    for (int i = 0; i < methods.count; i++) {
        NSString *string = methods[i];
        [hmethodContent appendString:string];
        [hmethodContent appendString:@";\n\n"];
        
        [mmethodContent appendString:string];
        if (i == methods.count - 1){
            [mmethodContent appendString:@"{\n    return NSStringFromSelector(_cmd);\n}\n\n"];
        }else{
            NSString *methodString = methods[i+1];
            NSString *separat = @" (NSString *)";
            NSString *com1 = [string componentsSeparatedByString:separat].firstObject;
            NSString *com2 = [methodString componentsSeparatedByString:separat].firstObject;
            if ([com1 isEqualToString:com2]){
                NSRange range = [methodString rangeOfString:@" (NSString *)"];
                NSString *result = [methodString substringWithRange:NSMakeRange(range.location+range.length, methodString.length-range.location-range.length)];
                [mmethodContent appendString:[NSString stringWithFormat:@"{\n    return [self %@];\n}\n\n",result]];
            }else{
                [mmethodContent appendString:@"{\n    return NSStringFromSelector(_cmd);\n}\n\n"];
            }
        }
    }
    NSMutableString *hContent = [NSMutableString string];
    NSMutableString *mContent = [NSMutableString string];
    for (int i = 0; i < hcomponent.count-1; i++) {
        NSString *hString = [hcomponent[i] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        NSString *noSpace = [hString stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([hString containsString:@"@interface"] && ![noSpace containsString:@"//@interface"]){
            [hContent appendString:hString];
            [hContent appendString:@"\n\n"];
            [hContent appendString:hmethodContent];
        }else{
            [hContent appendString:hString];
            [hContent appendString:@"\n\n"];
        }
        [hContent appendString:@"@end\n\n"];
    }
    
    for (int i = 0; i < mcomponent.count-1; i++) {
        NSString *mString = [mcomponent[i] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        NSString *noSpace = [mString stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([mString containsString:@"@implementation"] && ![noSpace containsString:@"//@implementation"]){
            [mContent appendString:mString];
            [mContent appendString:@"\n\n"];
            [mContent appendString:mmethodContent];
        }else{
            [mContent appendString:mString];
            [mContent appendString:@"\n\n"];
        }
        [mContent appendString:@"@end\n\n"];
    }
    
    [hContent appendString:[hcomponent.lastObject stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
    [mContent appendString:[mcomponent.lastObject stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
    
    [hContent writeToFile:hfilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [mContent writeToFile:mfilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (NSArray *)randomMethodName:(NSString *)path count:(int)count{
    NSSet *words = [self customWordsInPath:path];
    NSArray *wordsValue = words.allObjects;
    
    NSSet *result = [self combinedWords:wordsValue minLen:2 maxLen:5 count:count];
    NSMutableArray *mehods = [NSMutableArray array];
    for (NSString *string in result.allObjects) {
        NSString *methodString = [NSString stringWithFormat:@"%@ (NSString *)%@%@",self.randomMethodType,self.methodPrefix,string];
        [mehods addObject:methodString];
    }
    return mehods;
}

+ (NSSet *)combinedWords:(NSArray *)words minLen:(int)minLen maxLen:(int)maxLen count:(int)count{
    NSMutableSet *indexs = [NSMutableSet set];
    NSMutableSet *result = [NSMutableSet set];
    while (result.count < count) {
        int lenth = arc4random()%abs(maxLen - minLen) + minLen;
        while (indexs.count < lenth) {
            [indexs addObject:[NSNumber numberWithInt:arc4random()%words.count]];
        }
        NSString *methodString = @"";
        for (int i = 0; i < indexs.count;i++) {
            int index = [indexs.allObjects[i] intValue];
            NSString *wordString = words[index];
            if (i != 0) wordString = [wordString capitalizedString];
            methodString = [methodString stringByAppendingString:wordString];
        }
        [result addObject:methodString];
        [indexs removeAllObjects];
    }
    return result;
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
    NSSet *supple = [self randomWords];
    for (NSString *string in [supple allObjects]) {
        if (![result containsObject:string]) [result addObject:string];
    }
    [result removeObject:@"void"];
    [result removeObject:@"init"];
    return result;
}

+ (NSString *)randomMethodType{
    return  arc4random() % 2 == 1 ? @"-" : @"+";
}

+ (NSString *)methodPrefix{
    NSString *methodPrefix = TPConfoundSetting.sharedManager.spamSet.spamMethodPrefix;
    return methodPrefix ?: @"";
}

+ (NSSet *)randomWords{
    return [NSSet setWithArray:@[@"copy",@"alloc",@"with",@"value",@"manager",@"model",@"string",@"array",@"dictionary",@"mute",@"object",@"text",@"title",@"content",@"textView",@"textFiled",@"font",@"color",@"navigation",@"tabbar",@"device",@"toast",@"alert",@"router",@"path",@"file",@"height",@"size",@"window",@"delegate",@"protocol",@"empty",@"cache",@"refresh",@"image",@"word",@"setting",@"safe",@"reference", @"memory", @"process", @"concurrent", @"parallel", @"database", @"record", @"encryption",@"mine",@"home",@"demo",@"replace",@"runtime",@"hook",@"remove"]];
}
@end

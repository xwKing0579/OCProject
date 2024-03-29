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
            NSError *error = nil;
            NSMutableString *fileContent = [NSMutableString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
            [fileContent stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSArray *mehods = [fileContent regexPattern:@"@(void)\\s+([^:\\r\\n]+);"];
            int count = (int)(MIN(20, mehods.count) + arc4random()%5 + 1);
            NSArray *customMethods = [self randomMethodName:mfile count:count];
            [self createSpamMethods:customMethods toFilePath:[path stringByReplacingOccurrencesOfString:@".h" withString:@""]];
        }
    }
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
                NSString *randomString = @"NSStringFromSelector(_cmd)";
                int random = arc4random()%3;
                if (random == 2){
                    NSString *uuidString = [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    [uuidString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%u",arc4random()%10] withString:@""];
                    randomString = [NSString stringWithFormat:@"@\"%@\"",[uuidString lowercaseString]];
                }
                [mmethodContent appendString:[NSString stringWithFormat:@"{\n    return %@;\n}\n\n",randomString]];
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
    NSArray *wordsValue = [self randomWords];
    
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

+ (NSString *)randomMethodType{
    return  arc4random() % 2 == 1 ? @"-" : @"+";
}

+ (NSString *)methodPrefix{
    NSString *methodPrefix = TPConfoundSetting.sharedManager.spamSet.spamMethodPrefix;
    return methodPrefix ?: @"";
}

+ (NSArray *)randomWords{
    return TPConfoundSetting.sharedManager.spamSet.combinedWords;
}

+ (void)getWordsProjectPath:(NSString *)projectPath ignoreDirNames:(NSArray<NSString *> * __nullable)ignoreDirNames{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray<NSString *> *files = [fm contentsOfDirectoryAtPath:projectPath error:nil];
    NSMutableDictionary *wordCounts = TPConfoundSetting.sharedManager.spamSet.projectWords;
    for (NSString *filePath in files) {
        if ([ignoreDirNames containsObject:filePath]) continue;
        NSString *path = [projectPath stringByAppendingPathComponent:filePath];
        
        BOOL isDirectory;
        if ([fm fileExistsAtPath:path isDirectory:&isDirectory] && isDirectory) {
            [self getWordsProjectPath:path ignoreDirNames:ignoreDirNames];
            continue;
        }
        
        NSString *fileName = filePath.lastPathComponent;
        if ([fileName hasSuffix:@".m"]) {
            NSError *error = nil;
            NSMutableString *fileContent = [NSMutableString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
            NSArray *words = [fileContent filterString];
            for (NSString *word in words) {
                if (word.length > 0) {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[A-Za-z]+$"];
                    if ([predicate evaluateWithObject:word]){
                        NSString *key = [word lowercaseString];
                        if ([key hasPrefix:@"ui"]) key = [key stringByReplacingOccurrencesOfString:@"ui" withString:@""];
                        if ([key hasPrefix:@"ns"]) key = [key stringByReplacingOccurrencesOfString:@"ns" withString:@""];
                        if (key.length == 0) continue;
                        NSNumber *count = wordCounts[key];
                        if (count) {
                            wordCounts[key] = @(count.intValue + 1);
                        }else{
                            wordCounts[key] = @1;
                        }
                    }
                }
            }
        }
    }
}

@end

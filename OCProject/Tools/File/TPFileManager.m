//
//  TPFileManager.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/15.
//

#import "TPFileManager.h"

@implementation TPFileManager

+ (NSArray <TPFileModel *>*)defaultFile{
    NSMutableArray *data = [NSMutableArray array];
    
    NSArray *paths = @[NSHomeDirectory(),[NSBundle mainBundle].bundlePath];
    [paths enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TPFileModel *model = [TPFileModel new];
        model.isDirectory = YES;
        model.filePath = obj;
        model.fileName = obj.lastPathComponent;
        model.fileExtension = obj.pathExtension;
        model.fileType = TPFileTypeDirectory;
        model.fileSize = [self fileSize:obj];
        model.fileDate = [NSDate timeFromDate:[self fileDate:obj]];
        [data addObject:model];
    }];
     
    return data;
}

+ (NSArray <TPFileModel *>*)dataForFilePath:(NSString *)filePath{
    NSMutableArray *data = [NSMutableArray array];
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSURL *pathURL = [NSURL URLWithString:[filePath stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters]];
    if (!pathURL) return data;
    
    NSError *error;
    NSArray <NSURL *>*fileURLs = [NSFileManager.defaultManager contentsOfDirectoryAtURL:pathURL includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:&error];
    [fileURLs enumerateObjectsUsingBlock:^(NSURL * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isDirectory = NO;
        [NSFileManager.defaultManager fileExistsAtPath:obj.path isDirectory:&isDirectory];
        
        TPFileModel *model = [TPFileModel new];
        model.isDirectory = isDirectory;
        model.filePath = obj.path;
        model.fileName = obj.lastPathComponent;
        model.fileExtension = obj.pathExtension;
        model.fileType = isDirectory ? TPFileTypeDirectory : [self typeWithFileExtension:obj.pathExtension];
        model.fileSize = [self fileSize:obj.path];
        model.fileDate = [NSDate timeFromDate:[self fileDate:obj.path]];
        [data addObject:model];
    }];
    return data;
}

+ (TPFileType)typeWithFileExtension:(NSString *)fileExtension{
    TPFileType type = TPFileTypeDefault;
    if (!fileExtension.length) return type;
    
    if ([fileExtension containsString:@"png"] ||
        [fileExtension containsString:@"jpg"] ||
        [fileExtension containsString:@"jpeg"] ||
        [fileExtension containsString:@"gif"]) {
        type = TPFileTypeImage;
    }else if ([fileExtension containsString:@"mp3"] ||
              [fileExtension containsString:@"m4a"]){
        type = TPFileTypeAudio;
    }else if ([fileExtension containsString:@"db"] ||
              [fileExtension containsString:@"database"] ||
              [fileExtension containsString:@"sqlite"]){
        type = TPFileTypeDB;
    }else if ([fileExtension containsString:@"mp4"]){
        type = TPFileTypeVideo;
    }else if ([fileExtension containsString:@"pdf"]){
        type = TPFileTypePDF;
    }else if ([fileExtension containsString:@"doc"]){
        type = TPFileTypeDOC;
    }else if ([fileExtension containsString:@"ppt"]){
        type = TPFileTypePPT;
    }else if ([fileExtension containsString:@"plist"]){
        type = TPFileTypePlist;
    }else if ([fileExtension containsString:@"json"]){
        type = TPFileTypeJson;
    }else if ([fileExtension containsString:@"zip"]){
        type = TPFileTypeZip;
    }else if ([fileExtension containsString:@"html"]){
        type = TPFileTypeHTML;
    }
    return type;
}

+ (unsigned long long)fileSize:(NSString *)filePath{
    unsigned long long size = 0;
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isDirectory = NO;
    BOOL isExist = [NSFileManager.defaultManager fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (!isExist) return size;
    
    if (isDirectory){
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:filePath];
        for (NSString *subPath in enumerator) {
            NSString *fullPath = [filePath stringByAppendingPathComponent:subPath];
            size += [manager attributesOfItemAtPath:fullPath error:nil].fileSize;
        }
    }else{
        size += [manager attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    return size;
}

+ (NSDate *)fileDate:(NSString *)filePath{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDictionary *fileAttr = [manager attributesOfItemAtPath:filePath error:nil];
    return [fileAttr objectForKey:NSFileCreationDate];
}

@end

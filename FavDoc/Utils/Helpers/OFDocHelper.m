//
//  OFDocHelper.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/25.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFDocHelper.h"

#define MainFolder @"Doc1234"

@interface OFDocHelper()
{
    NSFileManager *_fm;
    
    // 主目录
    NSString *_mainPath;
}

@end

@implementation OFDocHelper


+ (OFDocHelper *)shareInstance {
    
    static OFDocHelper *_helper = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _helper = [[OFDocHelper alloc]init];
        
    });
    return _helper;
}

- (instancetype)init
{
    self =  [super init];

    if (self) {
        _fm = [NSFileManager defaultManager];
        
        // 判断并创建主目录
        
        _mainPath = [OFDocHelper fullPath:@"/"];
        
        if (![self fileExistsAtPath:@"/"]) {
            [self createDirectoryAtPath:@""];
            
            // 创建Demo
            [self createDirectoryAtPath:defaultFloder1];
            [self createDirectoryAtPath:defaultFloder2];
            
            NSString *fullDemoDir = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"jpg"];
            NSString *fullDstDir = [OFDocHelper fullPath:@"demo.jpg"];
            
            NSError *error;
            [_fm copyItemAtPath:fullDemoDir toPath:fullDstDir error:&error];
            if (error) {
                NSLog(@"creat demo pic error: %@",error);
            }
            
            NSString *fullDemoDir1 = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"mp4"];
            NSString *fullDstDir1 = [OFDocHelper fullPath:@"demo.mp4"];
            
            NSError *error1;
            [_fm copyItemAtPath:fullDemoDir1 toPath:fullDstDir1 error:&error1];
            if (error1) {
                NSLog(@"creat demo pic error: %@",error1);
            }
        }
    }
    
    return self;
    
}

#pragma mark - Doc Actions

- (NSDictionary *)getFilesFromPath:(NSString *)path
{
    
    if (![self fileExistsAtPath:path]) {
        
        NSLog(@"get flies list but path not exist!");
        return nil;
    }
    
    NSString *fullPath = [_mainPath stringByAppendingPathComponent:path];
    
    NSArray *arr = [_fm contentsOfDirectoryAtPath:fullPath error:nil];

    NSMutableArray *dirArr = [[NSMutableArray alloc] init];
    NSMutableArray *fileArr = [[NSMutableArray alloc] init];
    
    for (NSString *p1 in arr) {
        
        NSString *p2 = [fullPath stringByAppendingPathComponent:p1];
        
        BOOL isDir;
        if ([_fm fileExistsAtPath:p2 isDirectory:&isDir]) {
            if (isDir) {
                [dirArr addObject:p1];
            }else {
                [fileArr addObject:p1];
            }
        }
    }
    
    NSDictionary *dic = @{keyPath:path,keyFolder:dirArr,keyFile:fileArr};
    return dic;
    
}

- (NSDictionary *)getFlileInfoByPath:(NSString *)path
{
    if (![self fileExistsAtPath:path]) {
        
        NSLog(@"get flies info but path not exist!");
        NSDictionary *dic = nil;
        return dic;
    }
    
    NSString *fullPath = [_mainPath stringByAppendingPathComponent:path];

    NSError *error;
    NSDictionary *dic = [_fm attributesOfItemAtPath:fullPath error:&error];
    
    if (error) {
        NSLog(@"get file info error: %@",error);
        return nil;
    }
    return dic;
}


#pragma mark - file manager

- (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath
{
    NSError *error;
    
    if ([self fileExistsAtPath:srcPath] && [self fileExistsAtPath:dstPath]) {
        
        NSString *fullSrcPath = [_mainPath stringByAppendingPathComponent:srcPath];
        NSString *fullDstPath = [_mainPath stringByAppendingPathComponent:dstPath];
        
        [_fm copyItemAtPath:fullSrcPath toPath:fullDstPath error:&error];
        
    }else {
        NSLog(@"copy item but path wrong!");
        return NO;
    }
    
    if (error) {
        NSLog(@"copy item error: %@",error);
        return NO;
        
    }
    
    return YES;
}

- (BOOL)deleteItemAtPath:(NSString *)path
{
    NSError *error;
    BOOL isDir;
    
    if ([self fileExistsAtPath:path isDir:&isDir]) {
        
        NSString *fullPath = [_mainPath stringByAppendingPathComponent:path];
        
        [_fm removeItemAtPath:fullPath error:&error];
        
        // 移除收藏相关项目
        if (isDir) {
            [OFDocHelper deleteFavByDir:path];
        }else {
            [OFDocHelper deleteFav:path];
        }
        
    }else {
        NSLog(@"delete item but path wrong!");
        
        return NO;
    }
    
    if (error) {
        NSLog(@"delete item error: %@",error);
        return NO;
        
    }
    return YES;
}

- (BOOL)createDirectoryAtPath:(NSString *)path
{
    NSError *error;
    
    if (![self fileExistsAtPath:path]) {
        
        NSString *fullPath = [_mainPath stringByAppendingPathComponent:path];

        [_fm createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:&error];
    }else {
        NSLog(@"create dir but path wrong!");

        return NO;
    }
    
    if (error) {
        NSLog(@"create dir error: %@",error);
        return NO;

    }
    return YES;
}

- (BOOL)fileExistsAtPath:(NSString *)path
{
    BOOL isDir;
    
    return [self fileExistsAtPath:path isDir:&isDir];
}

- (BOOL)fileExistsAtPath:(NSString *)path isDir:(BOOL *)isDir
{
    
    NSString *fullPath = [_mainPath stringByAppendingPathComponent:path];
    
    BOOL isExist = [_fm fileExistsAtPath:fullPath isDirectory:isDir];
    
    return isExist;
}

#pragma mark - +
+ (NSString *)inMainPath:(NSString *)path
{
    
    NSString *inMainPath = [mainDirName stringByAppendingPathComponent:path];
    
    return inMainPath;
}

+ (NSString *)fullPath:(NSString *)path
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docDir = [paths objectAtIndex:0];

    NSString *mainPath = [docDir stringByAppendingPathComponent:MainFolder];

    NSString *fullPath = [mainPath stringByAppendingPathComponent:path];
    
    return fullPath;
    
}

+ (void)addToFav:(NSString *)path
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"path == %@",path];
    NSArray *results = [[OFCoreDataHelper shareInstance] fetcthTable:kTableFav predicate:predicate];
    
    OFFavEntity *entity = results.lastObject;
    if (entity == nil) {
        
        entity = [[OFCoreDataHelper shareInstance] insertToTable:kTableFav];
        entity.path = path;
        entity.name = [path lastPathComponent];
    }
    entity.date = [NSDate date];
    
    [[OFCoreDataHelper shareInstance] saveContext:kTableFav];
}

+ (void)addToHistory:(NSString *)path
{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"path == %@",path];
    NSArray *results = [[OFCoreDataHelper shareInstance] fetcthTable:kTableHistory predicate:predicate];
    
    OFHistoryEntity *entity = results.firstObject;
    
    if (entity == nil) {
        
        entity = [[OFCoreDataHelper shareInstance] insertToTable:kTableHistory];
        entity.path = path;
        entity.name = [path lastPathComponent];
    }
    entity.date = [NSDate date];
    
    [[OFCoreDataHelper shareInstance] saveContext:kTableHistory];
}

+ (NSArray *)getHistoryList:(NSInteger)maxNum
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor,nil];
    
    NSArray *results = [[OFCoreDataHelper shareInstance] fetcthTable:kTableHistory sortOption:sortDescriptors];
    
    if (results.count > maxNum) {
        results  = [results subarrayWithRange:NSMakeRange(0, maxNum)];
    }
    return results;
}

+ (NSArray *)getFavList:(NSInteger)maxNum
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor,nil];

    NSArray *results = [[OFCoreDataHelper shareInstance] fetcthTable:kTableFav sortOption:sortDescriptors];
    
    if (results.count > maxNum) {
        results  = [results subarrayWithRange:NSMakeRange(0, maxNum)];
    }
    return results;
}

+ (BOOL)isFav:(NSString *)path
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"path == %@",path];
    NSArray *results = [[OFCoreDataHelper shareInstance] fetcthTable:kTableFav predicate:predicate];
    if (results.count >0) {
        return YES;
    }
    return NO;
}

+ (void)deleteFav:(NSString *)path
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"path == %@",path];
    NSArray *results = [[OFCoreDataHelper shareInstance] fetcthTable:kTableFav predicate:predicate];

    for (OFFavEntity *entity in results) {
        [[OFCoreDataHelper shareInstance] deleteObject:entity];
    }
}

+ (void)deleteFavByDir:(NSString *)path
{
    NSArray *results = [[OFCoreDataHelper shareInstance] fetcthTable:kTableFav];
    
    for (OFFavEntity *entity in results) {
        
        NSRange range = [entity.path rangeOfString:path];
        
        if (range.location == 0 && range.length > 0) {
            [[OFCoreDataHelper shareInstance] deleteObject:entity];
        }
    }
}
@end

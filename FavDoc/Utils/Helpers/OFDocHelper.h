//
//  OFDocHelper.h
//  FavDoc
//
//  Created by Ricky Lin on 16/5/25.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import <Foundation/Foundation.h>

#define mainDirName @"/根目录"

#define defaultFloder1 @"/我的图片"
#define defaultFloder2 @"/我的文件"
#define defaultDemoFile @"/使用说明"

#define keyFolder @"folder"
#define keyFile @"files"
#define keyPath @"path"

@interface OFDocHelper : NSObject

+ (OFDocHelper *)shareInstance;

- (NSDictionary *)getFilesFromPath:(NSString *)path;

- (NSDictionary *)getFlileInfoByPath:(NSString *)path;

- (BOOL)createDirectoryAtPath:(NSString *)path;

- (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;

- (BOOL)deleteItemAtPath:(NSString *)path;

#pragma mark - +

// 前面加了一个根目录
+ (NSString *)inMainPath:(NSString *)path;

// 获得绝对路径
+ (NSString *)fullPath:(NSString *)path;

+ (void)addToFav:(NSString *)path;

+ (void)addToHistory:(NSString *)path;

+ (NSArray *)getHistoryList:(NSInteger)maxNum;

+ (NSArray *)getFavList:(NSInteger)maxNum;

+ (BOOL)isFav:(NSString *)path;

+ (void)deleteFav:(NSString *)path;

+ (void)deleteFavByDir:(NSString *)path;

@end

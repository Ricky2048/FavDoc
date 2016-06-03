//
//  OFDocHelper.h
//  FavDoc
//
//  Created by Ricky Lin on 16/5/25.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import <Foundation/Foundation.h>

#define keyFolder @"folder"
#define keyFile @"files"
#define keyPath @"path"

@interface OFDocHelper : NSObject

+ (OFDocHelper *)shareInstance;

- (NSDictionary *)getFilesFromPath:(NSString *)path;

- (NSDictionary *)getFlileInfoByPath:(NSString *)path;

- (BOOL)createDirectoryAtPath:(NSString *)path;

- (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;


#pragma mark - +

+ (NSString *)getFileSizeStr:(NSNumber *)filesize;

+ (NSString *)fullPath:(NSString *)path;

+ (void)addToFav:(NSString *)path;

+ (void)addToHistory:(NSString *)path;

+ (NSArray *)getHistoryList:(NSInteger)maxNum;

+ (NSArray *)getFavList:(NSInteger)maxNum;

+ (BOOL)isFav:(NSString *)path;

+ (void)deleteFav:(NSString *)path;

@end

//
//  Utils.h
//  FavDoc
//
//  Created by Ricky Lin on 16/5/26.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIkit/Uikit.h>

@interface Utils : NSObject

// 随机产生 num 位字符串
+ (NSString *)randomString:(NSInteger)num;

// 把date 转化成yyyyMMddHHMMss字符串
+ (NSString *)dateToString:(NSDate *)date;

// 把图片压缩到size的大小
+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;

// 等比压缩size的大小
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;


@end

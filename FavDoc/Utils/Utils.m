//
//  Utils.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/26.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "Utils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Utils

+ (NSString *)Md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+ (NSString *)randomString:(NSInteger)num
{
    num = MIN(num, 32);
    num = MAX(num, 1);
    
    char data[num];
    
    for (int x=0;x<num;data[x++] = (char)('a' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:num encoding:NSUTF8StringEncoding];
    
}

+ (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    
    return [formatter stringFromDate:date];

}

+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize
{
    
    UIImage *newimage;
    
    if (nil == image) {
        
        newimage = nil;
    }else {
        
        UIGraphicsBeginImageContext(asize);
        [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    
    if (nil == image) {
        
        newimage = nil;
    }else {
        
        CGSize oldsize = image.size;
        CGRect rect;
        
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }else {
            
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    return newimage;
}

+ (NSString *)getFileSizeStr:(NSNumber *)filesize
{
    NSInteger intSize = filesize.integerValue;
    
    float kSize = intSize/1000.0;
    if (kSize < 1) {
        return [NSString stringWithFormat:@"%ldB",intSize];
    }
    
    float mSize = kSize/1000.0;
    if (mSize < 1) {
        return [NSString stringWithFormat:@"%.1fK",kSize];
    }
    
    float gSize = mSize/1000.0;
    if (gSize < 1) {
        return [NSString stringWithFormat:@"%.1fM",mSize];
    }
    
    float tSize = gSize/1000.0;
    if (tSize < 1) {
        return [NSString stringWithFormat:@"%.1fG",gSize];
    }
    
    return [NSString stringWithFormat:@"%.1fT",tSize];
}

+ (NSString *)getTimeOffDateStr:(NSDate *)date
{
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    // 参数时间
    NSDateComponents *dateComps = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:date];
    
    int year = (int)[dateComps year];
    int month = (int)[dateComps month];
    int day = (int)[dateComps day];
    int hour = (int)[dateComps hour];
    int minute = (int)[dateComps minute];
//    int second = (int)[dateComps second];
    
    // 当前时间
    NSDateComponents *dateComps1 = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:[NSDate date]];
    
    int year1 = (int)[dateComps1 year];
    int month1 = (int)[dateComps1 month];
    int day1 = (int)[dateComps1 day];
    int hour1 = (int)[dateComps1 hour];
    int minute1 = (int)[dateComps1 minute];
//    int second1 = (int)[dateComps1 second];
    
    NSString *str = @"";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    if (year < year1) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        str = [formatter stringFromDate:date];
    }else if (month < month1) {
        [formatter setDateFormat:@"MM-dd HH:mm:ss"];
        str = [formatter stringFromDate:date];
    }else if (day < day1) {
        if (day+1 == day1) {
            [formatter setDateFormat:@"HH:mm:ss"];
            NSString *str1 = [formatter stringFromDate:date];
            str = [NSString stringWithFormat:@"%@%@",@"昨天",str1];
        }else {
            [formatter setDateFormat:@"MM-dd HH:mm:ss"];
            str = [formatter stringFromDate:date];
        }
    }else if (hour < hour1) {
        if (hour+1 == hour1 && minute1<minute) {
            str = [NSString stringWithFormat:@"%d%@",(minute1-minute+60),@"分钟前"];
        }else {
            [formatter setDateFormat:@"HH:mm:ss"];
            NSString *str1 = [formatter stringFromDate:date];
            str = [NSString stringWithFormat:@"%@%@",@"今天",str1];
        }
    }else if (minute < minute1) {
        str = [NSString stringWithFormat:@"%d%@",(minute1-minute),@"分钟前"];
        
    }else {
        str = @"刚刚";
    }
    
    return str;
}
@end

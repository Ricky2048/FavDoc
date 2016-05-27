//
//  Utils.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/26.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "Utils.h"

@implementation Utils

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
            
        }
        
        else{
            
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
@end

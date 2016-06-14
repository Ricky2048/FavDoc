//
//  OFClothHelper.m
//  FavDoc
//
//  Created by Ricky Lin on 16/6/14.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFClothHelper.h"

#define kColorClothGreen        @"#43CD80"

#define kColorClothRed          @"#EE0000"

#define kColorClothPink         @"#FF83FA"

#define kColorClothPurple       @"#AB82FF"

#define kColorClothBlue         @"#5CACEE"

#define kColorClothDark         @"#303030"

@interface OFClothHelper()
{
    OFColorClothType _currentType;
    
}
@end


@implementation OFClothHelper


+ (OFClothHelper *)shareInstance {
    
    static OFClothHelper *_helper = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _helper = [[OFClothHelper alloc]init];
        
        [_helper setCurrentColor:OFColorClothPurple];
    });
    return _helper;
}

- (UIColor *)currentColor
{
    NSString *colorStr = [self getColorStr:_currentType];
   
    return [UIColor ColorWithHexString:colorStr];
}

- (void)setCurrentColor:(OFColorClothType)colorType
{
    _currentType = colorType;
}

- (UIColor *)getColorByType:(OFColorClothType)colorType
{
    NSString *colorStr = [self getColorStr:colorType];
    
    return [UIColor ColorWithHexString:colorStr];
}

- (NSString *)getColorStr:(OFColorClothType)colorType
{
    
    NSString *colorStr = kColorClothGreen;

    switch (colorType) {
        case OFColorClothGreen:
            colorStr = kColorClothGreen;
            break;
        case OFColorClothRed:
            colorStr = kColorClothRed;
            break;
        case OFColorClothPink:
            colorStr = kColorClothPink;
            break;
        case OFColorClothPurple:
            colorStr = kColorClothPurple;
            break;
        case OFColorClothBlue:
            colorStr = kColorClothBlue;
            break;
        case OFColorClothDark:
            colorStr = kColorClothDark;
            break;
        default:
            break;
    }
    
    return colorStr;
}

@end

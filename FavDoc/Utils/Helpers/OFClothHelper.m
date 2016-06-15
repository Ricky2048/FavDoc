//
//  OFClothHelper.m
//  FavDoc
//
//  Created by Ricky Lin on 16/6/14.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFClothHelper.h"

#define kColorClothGreen        @"#71C671"

#define kColorClothRed          @"#FF6A6A"

#define kColorClothPink         @"#FF83FA"

#define kColorClothPurple       @"#AB82FF"

#define kColorClothBlue         @"#5CACEE"

#define kColorClothDark         @"#545454"

@interface OFClothHelper()
{
    OFColorClothType _currentType;
    
}
@end

@implementation OFClothHelper

+ (OFClothHelper *)shareInstance
{
    
    static OFClothHelper *_helper = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _helper = [[OFClothHelper alloc]init];
        
        NSNumber *type = getUserDefault(kUserDefaultKeyClothType);
        
        _helper.updateClothCount = 0;

        [_helper setCurrentColor:type.unsignedIntegerValue];
        
    });
    return _helper;
}

- (UIColor *)currentColor
{
    NSString *colorStr = [self getColorStr:_currentType];
   
    return [UIColor ColorWithHexString:colorStr];
}

- (OFColorClothType)currentClothType
{
    return _currentType;
}

- (void)setCurrentColor:(OFColorClothType)clothType
{
    _currentType = clothType;
    
    NSNumber *type = [NSNumber numberWithUnsignedInteger:clothType];
    
    setUserDefault(kUserDefaultKeyClothType, type);
    
    _updateClothCount ++;
    
    [_tabBarVC updateCloth];
}

- (UIColor *)getColorByType:(OFColorClothType)clothType
{
    NSString *colorStr = [self getColorStr:clothType];
    
    return [UIColor ColorWithHexString:colorStr];
}

- (NSString *)getColorStr:(OFColorClothType)clothType
{
    
    NSString *colorStr = kColorClothGreen;

    switch (clothType) {
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

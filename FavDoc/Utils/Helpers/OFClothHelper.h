//
//  OFClothHelper.h
//  FavDoc
//
//  Created by Ricky Lin on 16/6/14.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    OFColorClothGreen,
    OFColorClothRed,
    OFColorClothPink,
    OFColorClothPurple,
    OFColorClothBlue,
    OFColorClothDark
} OFColorClothType;

@interface OFClothHelper : NSObject

+ (OFClothHelper *)shareInstance;

- (UIColor *)currentColor;

- (void)setCurrentColor:(OFColorClothType)colorType;

- (UIColor *)getColorByType:(OFColorClothType)colorType;

@end

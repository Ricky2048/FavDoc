//
//  OFClothHelper.h
//  FavDoc
//
//  Created by Ricky Lin on 16/6/14.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OFMianTabbarController.h"

typedef enum : NSUInteger {
    OFColorClothGreen       = 0,
    OFColorClothRed         = 1,
    OFColorClothPink        = 2,
    OFColorClothPurple      = 3,
    OFColorClothBlue        = 4,
    OFColorClothDark        = 5
} OFColorClothType;

@interface OFClothHelper : NSObject

@property (nonatomic, weak)OFMianTabbarController *tabBarVC;

@property (nonatomic, assign)NSInteger updateClothCount;

+ (OFClothHelper *)shareInstance;

- (UIColor *)currentColor;

- (OFColorClothType)currentClothType;

- (void)setCurrentColor:(OFColorClothType)clothType;

- (UIColor *)getColorByType:(OFColorClothType)clothType;

@end

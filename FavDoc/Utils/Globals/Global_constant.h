//
//  Global_constant.h
//  FavDoc
//
//  Created by Ricky Lin on 16/6/4.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#ifndef Global_constant_h
#define Global_constant_h


#define SCREEN_RECT [[UIScreen mainScreen]bounds]
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height

#define KEYWINDOW [[[UIApplication sharedApplication]windows]objectAtIndex:0]

#define IOSVersion [[UIDevice currentDevice]systemVersion].floatValue
#define IOS7 [[[UIDevice currentDevice] systemVersion]floatValue]>=7
#define IOS8 [[[UIDevice currentDevice] systemVersion]floatValue]>=8

#define kUserDefaultKeyClothType    @"usserDefaultKeyClothType"

#define kUserDefaultKeyUserKey      @"userDefaultKeyUserKey"

#define setUserDefault(key, object) \
if (object == nil) \
[[NSUserDefaults standardUserDefaults] removeObjectForKey:(key)]; \
else \
[[NSUserDefaults standardUserDefaults] setObject:(object) forKey:(key)]; \
[[NSUserDefaults standardUserDefaults] synchronize];

#define getUserDefault(key) \
[[NSUserDefaults standardUserDefaults] objectForKey:(key)]


#endif /* Global_constant_h */

//
//  OFLockHelper.m
//  FavDoc
//
//  Created by Ricky Lin on 16/6/15.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFLockHelper.h"

@implementation OFLockHelper


+ (OFLockHelper *)shareInstance
{
    
    static OFLockHelper *_helper = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _helper = [[OFLockHelper alloc]init];
        
      
        
        
    });
    return _helper;
}
@end

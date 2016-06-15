//
//  OFDataHelper.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/24.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFDataHelper.h"

@implementation OFDataHelper

+ (OFDataHelper *)shareInstance
{
    
    static OFDataHelper *_helper = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _helper = [[OFDataHelper alloc]init];
        
        
    });
    return _helper;
}



@end

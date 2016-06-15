//
//  OFRecordHelper.m
//  FavDoc
//
//  Created by Ricky Lin on 16/6/15.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFRecordHelper.h"

@implementation OFRecordHelper

+ (OFRecordHelper *)shareInstance
{
    
    static OFRecordHelper *_helper = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _helper = [[OFRecordHelper alloc]init];
        
        
        
        
    });
    return _helper;
}
@end

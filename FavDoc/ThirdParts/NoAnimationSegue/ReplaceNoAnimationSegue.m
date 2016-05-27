//
//  ReplaceNoAnimationSegue.m
//  ZunestBroker-iPad
//
//  Created by Ricky Lin on 16/4/22.
//  Copyright © 2016年 Zunest. All rights reserved.
//

#import "ReplaceNoAnimationSegue.h"

@implementation ReplaceNoAnimationSegue

- (void)perform
{
    [self.sourceViewController presentViewController:self.destinationViewController animated:NO completion:^{
        
    }];
}

@end

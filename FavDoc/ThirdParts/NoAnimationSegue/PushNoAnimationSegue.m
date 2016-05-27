//
//  PushNoAnimationSegue.m
//  ZunestBroker-iPad
//
//  Created by Ricky Lin on 16/4/22.
//  Copyright © 2016年 Zunest. All rights reserved.
//

#import "PushNoAnimationSegue.h"

@implementation PushNoAnimationSegue

- (void)perform {
    
    [self.sourceViewController.navigationController pushViewController:self.destinationViewController animated:NO];
    
}

@end

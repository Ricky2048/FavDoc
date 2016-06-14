//
//  OFNoSelectionTextView.m
//  FavDoc
//
//  Created by Ricky Lin on 16/6/14.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFNoSelectionTextView.h"

@implementation OFNoSelectionTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)canBecomeFirstResponder{
    return NO;
}

@end

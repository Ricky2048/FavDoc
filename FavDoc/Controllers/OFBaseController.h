//
//  OFBaseController.h
//  FavDoc
//
//  Created by Ricky Lin on 16/5/24.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFBaseController : UIViewController
{
    NSInteger _updateClothCount;
    
    BOOL _isFirstLoad;
}

- (void)updateData;

- (void)updateCloth;

@end

//
//  OFCatalogView.h
//  FavDoc
//
//  Created by Ricky Lin on 16/5/24.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectDirBlock) (NSString *dir);

@interface OFCatalogView : UIView

@property (nonatomic, strong) NSString *path;

- (void)addSelectBlock:(SelectDirBlock)block;

- (void)updateCloth;

@end

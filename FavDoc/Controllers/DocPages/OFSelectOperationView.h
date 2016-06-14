//
//  OFSelectOperationView.h
//  FavDoc
//
//  Created by Ricky Lin on 16/5/26.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import <UIKit/UIKit.h>

#define numOfRow 5
#define hightOfRow 44
#define widthOfView 166

typedef enum : NSUInteger {
    OFSelectOperationCreateFolder,
    OFSelectOperationAddPhoto,
    OFSelectOperationClearFolder,
    OFSelectOperationMoveFolder
} OFSelectOperation;

typedef void (^SelectOperationBlock) (OFSelectOperation operation);

@interface OFSelectOperationView : UIView<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    UITableView *_tableView;
    
    NSArray *_dataSource;
    
    NSArray *_imageSource;
    
    SelectOperationBlock _operationBlock;
    
    UIView *_maskView;
    
    UIImageView *_topArrow;
    
}

- (void)updateCloth;

- (void)addSelectBlock:(SelectOperationBlock)block;

- (instancetype)initWithFrame:(CGRect)frame point:(CGPoint)point;

@end

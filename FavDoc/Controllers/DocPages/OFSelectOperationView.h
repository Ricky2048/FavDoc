//
//  OFSelectOperationView.h
//  FavDoc
//
//  Created by Ricky Lin on 16/5/26.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import <UIKit/UIKit.h>

#define numOfRow 6
#define hightOfRow 44
#define widthOfView 166

#define SelectOptionNewFolder   @"新建文件夹"
#define SelectOptionFromAblum   @"相册选择"
#define SelectOptionUSerCamera  @"相机拍摄"
#define SelectOptionNewText     @"新建录音"
#define SelectOptionNewRecord   @"新建文本"
#define SelectOptionPlaste      @"粘贴"

typedef void (^SelectOperationBlock) (NSString *selectOption);

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

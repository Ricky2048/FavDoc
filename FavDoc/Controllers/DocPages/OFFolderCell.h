//
//  OFFolderCell.h
//  FavDoc
//
//  Created by Ricky Lin on 16/5/26.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFFolderCell : UITableViewCell
{
    
    NSString *_path;
    NSString *_name;
}
- (void)setPath:(NSString *)path name:(NSString *)name;

@end

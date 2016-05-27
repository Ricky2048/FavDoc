//
//  OFDocCell.h
//  FavDoc
//
//  Created by Ricky Lin on 16/5/26.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFDocCell : UITableViewCell
{
    
    __weak IBOutlet UIImageView *_imageView;
    
    __weak IBOutlet UILabel *_fileTypeLabel;
    
    __weak IBOutlet UILabel *_nameLabel;
    
    __weak IBOutlet UILabel *_detailLabel;
    
    __weak IBOutlet UIButton *_moreBtn;

    __weak IBOutlet NSLayoutConstraint *_cs_typeLabel_left;
    
    __weak IBOutlet NSLayoutConstraint *_cs_detailLabel_left;

    __weak IBOutlet NSLayoutConstraint *_cs_typeLabel_width;

    __weak IBOutlet NSLayoutConstraint *_cs_nameLabel_left;

    NSString *_path;
    NSString *_name;
    
}

- (void)setPath:(NSString *)path name:(NSString *)name;

@end

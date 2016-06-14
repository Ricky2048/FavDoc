//
//  OFFavCell.m
//  FavDoc
//
//  Created by Ricky Lin on 16/6/3.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFFavCell.h"

@implementation OFFavCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImage *image = [[UIImage imageNamed:@"icon_file_28"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.imageView.tintColor = kColorAllStyle;
    self.imageView.image = image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEntity:(OFFavEntity *)entity
{
    self.textLabel.text = [entity.path lastPathComponent];
    
    self.detailTextLabel.text = [OFDocHelper inMainPath:[entity.path stringByDeletingLastPathComponent]];
}

@end

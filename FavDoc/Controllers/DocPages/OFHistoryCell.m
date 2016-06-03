//
//  OFHistoryCell.m
//  FavDoc
//
//  Created by Ricky Lin on 16/6/3.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFHistoryCell.h"

@implementation OFHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEntity:(OFHistoryEntity *)entity
{
    self.textLabel.text = [entity.path lastPathComponent];
    
    self.detailTextLabel.text = [entity.path stringByDeletingLastPathComponent];
}

@end

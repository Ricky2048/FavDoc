//
//  OFBaseCell.m
//  FavDoc
//
//  Created by Ricky Lin on 16/6/14.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFBaseCell.h"

@implementation OFBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self updateCloth];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCloth
{

}


@end

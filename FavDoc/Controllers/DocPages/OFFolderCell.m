//
//  OFFolderCell.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/26.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFFolderCell.h"

@implementation OFFolderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIImage *image = [[UIImage imageNamed:@"icon_floder_28"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.imageView.image = image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPath:(NSString *)path name:(NSString *)name
{
    _path = path;
    _name = name;
    
    self.textLabel.text = name;
    
    NSString *filePath = [path stringByAppendingPathComponent:name];
    NSDictionary *dic = [[OFDocHelper shareInstance] getFlileInfoByPath:filePath];
//    NSLog([dic description]);
    
//    NSNumber *fileSize = dic[NSFileSize];
//    NSString *sizeStr = [self getFileSizeStr:fileSize];
    
    NSDate *fileCreateDate = dic[NSFileCreationDate];
    NSString *createStr = [Utils getTimeOffDateStr:fileCreateDate];
    
//    NSDate *fileModifyDate = dic[NSFileCreationDate];
//    NSString *modifyStr = [formatter stringFromDate:fileModifyDate];
    
    NSString *detailStr = [NSString stringWithFormat:@"创建时间:%@",createStr];
    
    self.detailTextLabel.text = detailStr;

    [self updateCloth];
}

- (void)updateCloth
{
    self.imageView.tintColor = kColorAllStyle;
}

@end

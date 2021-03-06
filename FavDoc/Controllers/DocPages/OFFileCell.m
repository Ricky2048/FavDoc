//
//  OFFileCell.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/27.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFFileCell.h"

#import <MediaPlayer/MediaPlayer.h>

@implementation OFFileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _fileTypeLabel.layer.cornerRadius = 3;
    _fileTypeLabel.layer.masksToBounds = YES;
    _fileTypeLabel.layer.borderWidth = .5;
    
    _imageView.layer.cornerRadius = 3;
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.borderWidth = .5;
    
    _moreBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:24];
    [_moreBtn setTitle:@"\U0000e614" forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setPath:(NSString *)path name:(NSString *)name
{
    
    _path = path;
    _name = name;
    
    _nameLabel.text = _name;
    
    NSString *filePath = [_path stringByAppendingPathComponent:_name];
    NSDictionary *dic = [[OFDocHelper shareInstance] getFlileInfoByPath:filePath];
//    NSLog([dic description]);
    
    NSNumber *fileSize = dic[NSFileSize];
    NSString *sizeStr = [Utils getFileSizeStr:fileSize];

    NSDate *fileCreateDate = dic[NSFileCreationDate];
    NSString *createStr = [Utils getTimeOffDateStr:fileCreateDate];
    
    NSDate *fileModifyDate = dic[NSFileCreationDate];
    NSString *modifyStr = [Utils getTimeOffDateStr:fileModifyDate];
    
    NSString *extensionStr = [name pathExtension].uppercaseString;
    
    if (extensionStr.length > 0) {
        _fileTypeLabel.text = extensionStr;
        _cs_typeLabel_width.constant = 44;
        _cs_nameLabel_left.constant = 8;
        
    }else {
        _fileTypeLabel.text = @"";
        _cs_typeLabel_width.constant = 0;
        _cs_nameLabel_left.constant = 0;
    }
    
    NSString *detailStr = [NSString stringWithFormat:@"文件大小:%@ 创建时间:%@ 修改时间:%@",sizeStr,createStr,modifyStr];
    // 判断是否显示缩略图
    if (fileSize.unsignedIntegerValue > 0 && ([extensionStr isEqualToString:@"JPG"] || [extensionStr isEqualToString:@"PNG"])) {
        NSString *fullPath = [OFDocHelper fullPath:filePath];
        
        NSData *imageData = [[NSData alloc] initWithContentsOfFile:fullPath];
        UIImage *image = [UIImage imageWithData:imageData];
        UIImage *thumbImage = [Utils thumbnailWithImage:image size:CGSizeMake(40, 40)];
        
        CGSize size = image.size;
        
        detailStr = [NSString stringWithFormat:@"大小:%@ 尺寸:%.0fx%.0f 创建时间:%@ 修改时间:%@",sizeStr,size.width,size.height,createStr,modifyStr];
        
        _imageView.image = thumbImage;
        _imageView.hidden = NO;
        
        _cs_detailLabel_left.constant = 55;
        _cs_typeLabel_left.constant = 55;
        
//    }else if (fileSize.unsignedIntegerValue > 0 && [extensionStr isEqualToString:@"MP4"]) {
//        NSString *fullPath = [OFDocHelper fullPath:filePath];
//
//        MPMoviePlayerController *player = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:fullPath]];
//        UIImage  *thumbImage = [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
//        _imageView.image = thumbImage;
//        _cs_detailLabel_left.constant = 55;
//        _cs_typeLabel_left.constant = 55;
    } else {
        _imageView.image = nil;
        _imageView.hidden = YES;
        
        _cs_detailLabel_left.constant = 8;
        _cs_typeLabel_left.constant = 8;
    }
    
    _detailLabel.text = detailStr;
    
    // 判断是否已经收藏

    if ([OFDocHelper isFav:filePath]) {
        [_moreBtn setTitle:@"\U0000e606" forState:UIControlStateNormal];
    }else {
        [_moreBtn setTitle:@"\U0000e614" forState:UIControlStateNormal];
    }
    
    [self updateCloth];
}

- (void)updateCloth
{
    [_moreBtn setTitleColor:kColorAllStyle forState:UIControlStateNormal];
    _imageView.layer.borderColor =  kColorLine.CGColor;
    _fileTypeLabel.backgroundColor = kColorAllStyle;
    _fileTypeLabel.highlightedTextColor = kColorAllStyle;
    _fileTypeLabel.layer.borderColor =  kColorAllStyle.CGColor;
}

- (NSString *)getDateStr:(NSDate *)date
{
    return @"1231.3.5";
}
- (IBAction)moreAction:(id)sender {
    
    NSString *filePath = [_path stringByAppendingPathComponent:_name];

    if (![OFDocHelper isFav:filePath]) {
        [OFDocHelper addToFav:filePath];
        [_moreBtn setTitle:@"\U0000e606" forState:UIControlStateNormal];
    }else {
        [OFDocHelper deleteFav:filePath];
        [_moreBtn setTitle:@"\U0000e614" forState:UIControlStateNormal];
    }
    
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end

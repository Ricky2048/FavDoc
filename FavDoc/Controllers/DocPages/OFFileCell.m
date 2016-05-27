//
//  OFFileCell.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/27.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFFileCell.h"

@implementation OFFileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _fileTypeLabel.layer.cornerRadius = 3;
    _fileTypeLabel.layer.masksToBounds = YES;
    
    _imageView.layer.cornerRadius = 3;
    _imageView.layer.masksToBounds = YES;
    
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
    NSString *sizeStr = [OFDocHelper getFileSizeStr:fileSize];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *fileCreateDate = dic[NSFileCreationDate];
    NSString *createStr = [formatter stringFromDate:fileCreateDate];
    
    NSDate *fileModifyDate = dic[NSFileCreationDate];
    NSString *modifyStr = [formatter stringFromDate:fileModifyDate];
    
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
        _cs_detailLabel_left.constant = 55;
        _cs_typeLabel_left.constant = 55;
        
    }else {
        _imageView.image = nil;
        
        _cs_detailLabel_left.constant = 8;
        _cs_typeLabel_left.constant = 8;
    }
    
    _detailLabel.text = detailStr;
}

- (NSString *)getDateStr:(NSDate *)date
{
    return @"1231.3.5";
}
- (IBAction)moreAction:(id)sender {
    
    [self addToFav:[_path stringByAppendingPathComponent:_name]];
}

- (void)addToFav:(NSString *)path
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"path == %@",path];
    NSArray *results = [[OFDataHelper shareInstance] fetcthTable:kTableFav predicate:predicate];
    
    OFFavEntity *entity = results.lastObject;
    if (entity == nil) {
        
        entity = [[OFDataHelper shareInstance] insertToTable:kTableFav];
        entity.path = path;
        entity.name = [path lastPathComponent];
    }
    entity.collect_date = [NSDate date];
    
}


@end

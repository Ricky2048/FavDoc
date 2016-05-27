//
//  OFCatalogView.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/24.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFCatalogView.h"

#define mainDirName @"/根目录"

@interface OFCatalogView()<UITextViewDelegate>
{
    
    __weak IBOutlet UIScrollView *_scrollView;
    
    __weak IBOutlet UITextView *_pathTextView;
    
    __weak IBOutlet UIButton *_backBtn;
    
    __weak IBOutlet UIButton *_operateBtn;

    __weak IBOutlet NSLayoutConstraint *_cs_textView_width;

    
    NSArray *_pathArray;
    
    NSMutableAttributedString *_folderAttStr;
    
    SelectDirBlock _dirBlock;
}

@end

@implementation OFCatalogView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
      

    }
    
    return self;
    
}

- (void)awakeFromNib
{
    _pathTextView.delegate = self;
    _pathTextView.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);
    _pathTextView.textContainer.lineFragmentPadding = 0;
    _pathTextView.textContainer.maximumNumberOfLines = 1;
    _pathTextView.textContainer.lineBreakMode = NSLineBreakByTruncatingHead;
}

- (void)setPath:(NSString *)path
{
//    NSLog(@"--- %@",path);
    _path = path;
    
    NSString *mianDir = mainDirName;
    
    NSString *newPath = [mianDir stringByAppendingPathComponent:_path];
    
    if ([newPath isAbsolutePath]) {
        _pathArray = [newPath pathComponents];
        
        _folderAttStr = [[NSMutableAttributedString alloc] init];
        
        if (_pathArray == nil) {
            _pathArray = @[@"/"];
        }
        for (int i=0; i<_pathArray.count; i++) {
       
            NSString *str = _pathArray[i];
            
            if (![str isEqualToString:@"/"]) {
                
                NSAttributedString *att1 = [[NSAttributedString alloc] initWithString:@" /" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
                [_folderAttStr appendAttributedString:att1];
                
                NSArray *arr = [_pathArray subarrayWithRange:NSMakeRange(0, i+1)];
                NSString *urlStr = [NSString pathWithComponents:arr];
                NSString * encodingString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSAttributedString *att2 = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blueColor],NSLinkAttributeName:[NSURL URLWithString:encodingString]}];
                [_folderAttStr appendAttributedString:att2];
                
            }
        }
    }else {
        NSLog(@"no march dir!");
    }
    
    [self updateData];
}

- (void)addSelectBlock:(SelectDirBlock)block
{
    _dirBlock = block;
}

- (void)updateData
{
    CGSize size = [_folderAttStr boundingRectWithSize:CGSizeMake(5000, 29) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    size.width +=15;

    _scrollView.contentOffset = CGPointMake(MAX(0, size.width-_scrollView.frame.size.width), 0);
    
    _pathTextView.attributedText = _folderAttStr;
    
    _cs_textView_width.constant = size.width;

}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)url inRange:(NSRange)characterRange
{
    
    NSString *path = [url.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *pathArr = [path pathComponents];
    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:pathArr];
    [mutArr removeObjectAtIndex:1];
    
    NSString *newPath = [NSString pathWithComponents:mutArr];
    NSLog(@"%@",[newPath description]);
    
    if (_dirBlock) {
        _dirBlock(newPath);
    }
    
    return NO;
}

@end

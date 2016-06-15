//
//  OFSelectOperationView.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/26.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFSelectOperationView.h"

@implementation OFSelectOperationView

- (instancetype)initWithFrame:(CGRect)frame point:(CGPoint)point
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        [self addSubview:_maskView];
        
        [self setData];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(point.x-4, point.y+4, widthOfView, hightOfRow*numOfRow)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _tableView.layer.cornerRadius = 3;
        [self addSubview:_tableView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMaskView)];
        tap.delegate = self;
        [_maskView addGestureRecognizer:tap];
        
        _topArrow = [[UIImageView alloc] initWithFrame:CGRectMake(_tableView.left + _tableView.width - 26, _tableView.top - 14, 20, 20)];
        _topArrow.image = [[UIImage imageNamed:@"icon_topArrow_20"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

        [self addSubview:_topArrow];
        
        [self updateCloth];

    }
    
    return self;
}

- (void)updateCloth
{
    
    _tableView.separatorColor = kColorLine;
    _tableView.backgroundColor = kColorTabBarBg;
    _topArrow.tintColor = kColorTabBarBg;

    [_tableView reloadData];
}

- (void)setData
{
    _dataSource = @[SelectOptionNewFolder,
                    SelectOptionFromAblum,
                    SelectOptionUSerCamera,
                    SelectOptionNewText,
                    SelectOptionNewRecord,
                    SelectOptionPlaste];
    
    _imageSource = @[@"icon_floder_1_28",
                     @"icon_album_28",
                     @"icon_camera_28",
                     @"icon_record_28",
                     @"icon_text_28",
                     @"icon_plaste_28"];
}

- (void)addSelectBlock:(SelectOperationBlock)block
{
    _operationBlock = block;
}


- (void)hideMaskView
{
    self.hidden = YES;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return hightOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    NSString *name = _dataSource[indexPath.row];
    cell.textLabel.text = name;
    
    UIImage *image = [UIImage imageNamed:_imageSource[indexPath.row]];
    cell.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.imageView.tintColor = kColorAllStyle;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_operationBlock) {
        NSString *name = _dataSource[indexPath.row];
        _operationBlock(name);
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    //NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

@end

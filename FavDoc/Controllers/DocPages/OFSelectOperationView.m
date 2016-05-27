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
        
        _dataSource = @[@"新建文件夹",@"新增图片",@"清空目录",@"移动目录"];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(point.x, point.y, widthOfView, hightOfRow*numOfRow)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [self addSubview:_tableView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMaskView)];
        tap.delegate = self;
        [_maskView addGestureRecognizer:tap];
        
    }
    
    return self;
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

    NSString *name = _dataSource[indexPath.row];
    cell.textLabel.text = name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_operationBlock) {
        _operationBlock(indexPath.row);
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

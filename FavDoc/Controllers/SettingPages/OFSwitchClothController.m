//
//  OFSwitchClothController.m
//  FavDoc
//
//  Created by Ricky Lin on 16/6/14.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFSwitchClothController.h"

@interface OFSwitchClothController ()<UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UITableView *_tableView;
    
    
    NSArray *_dataSource;
    NSArray *_colorSource;

    UIColor *_selectColor;
 
    NSIndexPath *_lastIndexPath;
    
}
@end

@implementation OFSwitchClothController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"切换皮肤";
    
    [self setData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Action

- (void)setData
{
    _dataSource = @[@"绿色",
                    @"红色",
                    @"粉色",
                    @"紫色",
                    @"蓝色",
                    @"黑色"];
    
    OFClothHelper *helper = [OFClothHelper shareInstance];
    
    _colorSource = @[[helper getColorByType:OFColorClothGreen],
                     [helper getColorByType:OFColorClothRed],
                     [helper getColorByType:OFColorClothPink],
                     [helper getColorByType:OFColorClothPurple],
                     [helper getColorByType:OFColorClothBlue],
                     [helper getColorByType:OFColorClothDark]
                     ];
 
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *text = _dataSource[indexPath.row];
    cell.textLabel.text = text;
    
    cell.detailTextLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.tintColor = kColorTabBarBg;
    
    UIColor *color = _colorSource[indexPath.row];
    cell.backgroundColor = color;
   
    OFColorClothType type = [[OFClothHelper shareInstance] currentClothType];

    if (indexPath.row == type) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        _lastIndexPath = indexPath;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
       
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[OFClothHelper shareInstance] setCurrentColor:indexPath.row];
    
    UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:_lastIndexPath];
    cell1.accessoryType = UITableViewCellAccessoryNone;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;

    _lastIndexPath = indexPath;
}
@end

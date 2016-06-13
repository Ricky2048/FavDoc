//
//  OFMoreController.m
//  FavDoc
//
//  Created by Ricky Lin on 16/6/3.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFMoreController.h"

@interface OFMoreController ()<UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UITableView *_tableView;

    
    NSArray *_dataSource;
    NSArray *_imageSource;
}
@end

@implementation OFMoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.title = @"设置";
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
    _dataSource = @[@"访问密码",
                    @"使用统计",
                    @"历史记录",
                    @"收藏夹",
                    @"关于App",
                    @"UserKey",
                    @"联系作者",
                    @"重置所有内容"];
    
    _imageSource = @[@"icon_secret_28",
                     @"icon_statistic_28",
                     @"icon_history_28",
                     @"icon_fav_28",
                     @"icon_info_28",
                     @"icon_key_28",
                     @"icon_email_28",
                     @"icon_reset_28"];
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
    UIImage *image = [UIImage imageNamed:_imageSource[indexPath.row]];
    cell.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.imageView.tintColor = kColorTabBarBg;
    
    cell.detailTextLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryNone;

    if ([text isEqualToString:@"访问密码"]) {
        cell.detailTextLabel.text = @"未开启";
    }
    if ([text isEqualToString:@"使用统计"]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if ([text isEqualToString:@"历史记录"]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if ([text isEqualToString:@"收藏夹"]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if ([text isEqualToString:@"关于App"]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"v%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    }
    if ([text isEqualToString:@"UserKey"]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.text = @"Random";
    }
    if ([text isEqualToString:@"联系作者"]) {
        cell.detailTextLabel.text = @"有啥事发个邮件呗";
    }
    if ([text isEqualToString:@"重置所有内容"]) {
        cell.detailTextLabel.text = @"请谨慎使用本功能";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end

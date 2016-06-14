//
//  OFMoreController.m
//  FavDoc
//
//  Created by Ricky Lin on 16/6/3.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFMoreController.h"

#define keyPassword     @"访问密码"
#define keyCloth        @"切换皮肤"
#define keyStatistic    @"使用统计"
#define keyHistory      @"历史记录"
#define keyFav          @"收藏夹"
#define keyAbout        @"关于App"
#define keyUserKey      @"UserKey"
#define keyContact      @"联系作者"
#define keyReset        @"重置所有内容"

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

- (void)updateCloth
{
    [_tableView reloadData];
    _tableView.separatorColor = kColorLine;

}

- (void)setData
{
    _dataSource = @[keyPassword,
                    keyCloth,
                    keyStatistic,
                    keyHistory,
                    keyFav,
                    keyAbout,
                    keyUserKey,
                    keyContact,
                    keyReset];
    
    _imageSource = @[@"icon_lock_28",
                     @"iocn_clouth_28",
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
    cell.imageView.tintColor = kColorAllStyle;
    
    cell.detailTextLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryNone;

    if ([text isEqualToString:keyPassword]) {
        cell.detailTextLabel.text = @"未开启";
    }
    if ([text isEqualToString:keyCloth]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if ([text isEqualToString:keyStatistic]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if ([text isEqualToString:keyHistory]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if ([text isEqualToString:keyFav]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if ([text isEqualToString:keyAbout]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"v%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    }
    if ([text isEqualToString:keyUserKey]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *userKey = getUserDefault(kUserDefaultKeyUserKey);
        cell.detailTextLabel.text = userKey;
    }
    if ([text isEqualToString:keyContact]) {
        cell.detailTextLabel.text = @"有啥事发个邮件呗";
    }
    if ([text isEqualToString:keyReset]) {
        cell.detailTextLabel.text = @"请谨慎使用本功能";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *text = _dataSource[indexPath.row];

    if ([text isEqualToString:keyCloth]) {
        [self performSegueWithIdentifier:kSegueSettingToCloth sender:self];
    }
    if ([text isEqualToString:keyHistory]) {
        [self performSegueWithIdentifier:kSegueSettingToHistory sender:self];
    }
    if ([text isEqualToString:keyFav]) {
        [self performSegueWithIdentifier:kSegueSettingToFav sender:self];
    }
}

@end

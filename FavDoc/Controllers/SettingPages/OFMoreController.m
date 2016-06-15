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
#define keyStatistic    @"用量统计"
#define keyTimeLine     @"操作轨迹"
#define keyHistory      @"历史记录"
#define keyFav          @"收藏夹"
#define keyAbout        @"关于App"
#define keyUserKey      @"UserKey"
#define keyContact      @"联系作者"
#define keyShare        @"推荐给朋友"
#define keyScore        @"给我打分"
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
    _dataSource = @[@[keyPassword,
                    keyCloth,
                    keyStatistic,
                    keyTimeLine,
                    keyHistory,
                    keyFav],
                   @[keyAbout,
                    keyUserKey,
                    keyShare,
                    keyScore,
                    keyContact,
                    keyReset]];
    
    _imageSource = @[@[@"icon_lock_28",
                       @"iocn_clouth_28",
                       @"icon_statistic_28",
                       @"icon_line_28",
                       @"icon_history_28",
                       @"icon_fav_28"],
                     @[@"icon_info_28",
                       @"icon_key_28",
                       @"icon_share_28",
                       @"icon_score_28",
                       @"icon_email_28",
                       @"icon_reset_28"]];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *array = _dataSource[section];
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSArray *array = _dataSource[indexPath.section];
    NSString *text = array[indexPath.row];
    cell.textLabel.text = text;
    
    NSArray *array1 = _imageSource[indexPath.section];
    UIImage *image = [UIImage imageNamed:array1[indexPath.row]];
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
    if ([text isEqualToString:keyTimeLine]) {
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
    if ([text isEqualToString:keyShare]) {
        cell.detailTextLabel.text = @"好东西需要您的分享";
    }
    if ([text isEqualToString:keyScore]) {
        cell.detailTextLabel.text = @"您的支持是我前进的动力";
    }
    if ([text isEqualToString:keyContact]) {
        cell.detailTextLabel.text = @"有啥对我说的吗";
    }
    if ([text isEqualToString:keyReset]) {
        cell.detailTextLabel.text = @"请谨慎使用本功能";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *array = _dataSource[indexPath.section];
    NSString *text = array[indexPath.row];
    
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

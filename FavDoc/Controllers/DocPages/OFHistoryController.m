//
//  OFHistoryController.m
//  FavDoc
//
//  Created by Ricky Lin on 16/6/3.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFHistoryController.h"
#import "OFHistoryCell.h"

@interface OFHistoryController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    __weak IBOutlet UITableView *_tableView;
    
    NSArray *_historyList;
    
    UIButton *_rightBtn;
}
@end

@implementation OFHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
    _historyList = @[];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightBtn.frame = CGRectMake(0, 5, 60, 30);
    [_rightBtn setTitle:@"一键清空" forState:UIControlStateNormal];


    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    if (self.tabBarController) {
        [self.tabBarController.navigationItem setRightBarButtonItem:barItem];
    }else {
        [self.navigationItem setRightBarButtonItem:barItem];
    }
    
    self.tabBarController.title = @"历史记录";
    self.title = @"历史记录";
    [self updateData];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (self.tabBarController) {
        [self.tabBarController.navigationItem setRightBarButtonItem:nil];
    }
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

#pragma mark - Actions

- (void)updateCloth
{
    _tableView.separatorColor = kColorLine;
    
    [_tableView reloadData];
}

- (void)updateData
{
    _historyList = [OFDocHelper getHistoryList:20];

    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _historyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    OFHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    OFHistoryEntity *entity = _historyList[indexPath.row];
    
    [cell setEntity:entity];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    
}

@end

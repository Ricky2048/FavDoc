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
}
@end

@implementation OFHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
    _historyList = @[];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.tabBarController.title = @"历史记录";

    [self updateData];

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
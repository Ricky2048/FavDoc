//
//  OFFavController.m
//  FavDoc
//
//  Created by Ricky Lin on 16/6/3.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFFavController.h"
#import "OFFavCell.h"

@interface OFFavController ()<UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UITableView *_tableView;
    
    NSArray *_favList;
}
@end

@implementation OFFavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _tableView.separatorColor = kColorAllStyle;

    _favList = @[];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.title = @"收藏夹";
    
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

- (void)updateData
{
    _favList = [OFDocHelper getFavList:20];
    
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _favList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    OFFavCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    OFFavEntity *entity = _favList[indexPath.row];
    
    [cell setEntity:entity];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end

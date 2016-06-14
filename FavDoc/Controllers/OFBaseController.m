//
//  OFBaseController.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/24.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFBaseController.h"

@interface OFBaseController ()

@end

@implementation OFBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self updateCloth];
    
    _updateClothCount = [OFClothHelper shareInstance].updateClothCount;
    
    _isFirstLoad = YES;

    self.view.backgroundColor = kColorViewBg;

}

- (void)viewWillAppear:(BOOL)animated
{
    if ([OFClothHelper shareInstance].updateClothCount > _updateClothCount || _isFirstLoad) {
        
        _updateClothCount = [OFClothHelper shareInstance].updateClothCount;
        
        [self updateCloth];
    }
    
    _isFirstLoad = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateData
{
    
}

- (void)updateCloth
{

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

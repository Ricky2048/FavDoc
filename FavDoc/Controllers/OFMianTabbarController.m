//
//  OFMianTabbarController.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/24.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFMianTabbarController.h"

@interface OFMianTabbarController ()

@end

@implementation OFMianTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationController.navigationBar.barTintColor = kColorNavBg;
    
//    self.navigationController.navigationBar.tintColor = [UIColor ColorWithHexString:@"#FFFFFF"];
  
    // 白色标题
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;

    
    self.tabBar.barTintColor = kColorTabBarBg;
    
    self.tabBar.tintColor = kColorAllStyle;
 
    

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

@end

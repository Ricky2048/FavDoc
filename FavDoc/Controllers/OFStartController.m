//
//  OFStartController.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/24.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import "OFStartController.h"

@implementation OFStartController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self checkUserKey];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self performSegueWithIdentifier:kSegueStartToMian sender:self];

}

- (void)checkUserKey
{
    NSString *userKey = getUserDefault(kUserDefaultKeyUserKey);
    
    if (userKey == nil) {
        
        userKey = [Utils randomString:16];
        
        setUserDefault(kUserDefaultKeyUserKey, userKey);
    }
}

@end

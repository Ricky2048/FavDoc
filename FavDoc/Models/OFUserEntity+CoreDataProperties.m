//
//  OFUserEntity+CoreDataProperties.m
//  FavDoc
//
//  Created by Ricky Lin on 16/5/25.
//  Copyright © 2016年 OneFish. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "OFUserEntity+CoreDataProperties.h"

@implementation OFUserEntity (CoreDataProperties)

@dynamic email;
@dynamic mobile;
@dynamic name;
@dynamic password;
@dynamic password_md5;
@dynamic user_id;
@dynamic date_latest_login;

@end

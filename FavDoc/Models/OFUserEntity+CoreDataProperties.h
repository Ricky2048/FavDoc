//
//  OFUserEntity+CoreDataProperties.h
//  FavDoc
//
//  Created by Ricky Lin on 16/5/25.
//  Copyright © 2016年 OneFish. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "OFUserEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface OFUserEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *mobile;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSString *password_md5;
@property (nullable, nonatomic, retain) NSNumber *user_id;
@property (nullable, nonatomic, retain) NSDate *date_latest_login;

@end

NS_ASSUME_NONNULL_END

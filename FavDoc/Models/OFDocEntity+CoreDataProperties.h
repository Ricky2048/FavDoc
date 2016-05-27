//
//  OFDocEntity+CoreDataProperties.h
//  FavDoc
//
//  Created by Ricky Lin on 16/5/25.
//  Copyright © 2016年 OneFish. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "OFDocEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface OFDocEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date_create;
@property (nullable, nonatomic, retain) NSDate *date_open;
@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) NSNumber *doc_id;
@property (nullable, nonatomic, retain) NSNumber *is_delete;
@property (nullable, nonatomic, retain) NSNumber *is_fav;
@property (nullable, nonatomic, retain) NSNumber *is_hide;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *path;
@property (nullable, nonatomic, retain) NSNumber *remark_color;
@property (nullable, nonatomic, retain) NSNumber *size;

@end

NS_ASSUME_NONNULL_END

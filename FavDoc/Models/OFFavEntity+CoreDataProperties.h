//
//  OFFavEntity+CoreDataProperties.h
//  FavDoc
//
//  Created by Ricky Lin on 16/5/27.
//  Copyright © 2016年 OneFish. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "OFFavEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface OFFavEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *path;
@property (nullable, nonatomic, retain) NSNumber *remark_color;
@property (nullable, nonatomic, retain) NSNumber *fav_id;

@end

NS_ASSUME_NONNULL_END

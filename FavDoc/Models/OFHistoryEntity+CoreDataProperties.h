//
//  OFHistoryEntity+CoreDataProperties.h
//  FavDoc
//
//  Created by Ricky Lin on 16/5/27.
//  Copyright © 2016年 OneFish. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "OFHistoryEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface OFHistoryEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *last_open;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *path;
@property (nullable, nonatomic, retain) NSNumber *history_id;

@end

NS_ASSUME_NONNULL_END

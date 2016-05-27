//
//  OFDataHelper.h
//  FavDoc
//
//  Created by Ricky Lin on 16/5/24.
//  Copyright © 2016年 OneFish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface OFDataHelper : NSObject
{

}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


+ (OFDataHelper *)shareInstance;

- (id)insertToTable:(NSString *)tName;

- (NSArray *)fetcthTable:(NSString *)tName;
- (NSArray *)fetcthTable:(NSString *)tName predicate:(NSPredicate *)predicate;

- (void)saveContext;

- (void)saveContext:(NSString *)currectObject;

@end

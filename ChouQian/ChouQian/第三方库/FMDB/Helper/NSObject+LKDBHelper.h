//
//  NSObject+LKDBHelper.h
//  LKDBHelper
//
//  Created by upin on 13-6-8.
//  Copyright (c) 2013年 ljh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"

@class LKDBHelper;
@interface NSObject(LKDBHelper)

//callback delegate
+(void)dbDidCreateTable:(LKDBHelper*)helper;

+(void)dbWillInsert:(NSObject*)entity;
+(void)dbDidInserted:(NSObject*)entity result:(BOOL)result;

+(void)dbWillUpdate:(NSObject*)entity;
+(void)dbDidUpdated:(NSObject*)entity result:(BOOL)result;

+(void)dbWillDelete:(NSObject*)entity;
+(void)dbDidIDeleted:(NSObject*)entity result:(BOOL)result;


//only simplify synchronous function
+(int)rowCountWithWhere:(id)where tableName:(NSString*)tableName;
+(NSMutableArray*)searchWithWhere:(id)where orderBy:(NSString*)orderBy offset:(int)offset count:(int)count tableName:(NSString*)tableName;
+(BOOL)insertToDB:(NSObject*)model tableName:(NSString*)tableNames;
+(BOOL)insertWhenNotExists:(NSObject*)model tableName:(NSString*)tableName;
+(BOOL)updateToDB:(NSObject *)model where:(id)where tableName:(NSString*)tableName;
+(BOOL)updateToDBWithSet:(NSString*)sets where:(id)where tableName:(NSString*)tableName;
+(BOOL)deleteToDB:(NSObject*)model tableName:(NSString*)tableName;
+(BOOL)deleteWithWhere:(id)where tableName:(NSString*)tableName;
+(BOOL)isExistsWithModel:(NSObject*)model tableName:(NSString*)tableName;

- (void)saveToDB:(NSString*)tableName;
- (void)deleteToDB:(NSString*)tableName;

//  add by zqb 20.13.10.30
+ (id)searchSingleWithWhere:(id)where orderBy:(NSString*)orderBy tableName:(NSString*)tableName;
@end
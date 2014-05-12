//
//  NSObject+LKDBHelper.m
//  LKDBHelper
//
//  Created by upin on 13-6-8.
//  Copyright (c) 2013年 ljh. All rights reserved.
//

#import "NSObject+LKDBHelper.h"


@implementation NSObject(LKDBHelper)

+(void)dbDidCreateTable:(LKDBHelper *)helper{}

+(void)dbDidIDeleted:(NSObject *)entity result:(BOOL)result{}
+(void)dbWillDelete:(NSObject *)entity{}

+(void)dbDidInserted:(NSObject *)entity result:(BOOL)result{}
+(void)dbWillInsert:(NSObject *)entity{}

+(void)dbDidUpdated:(NSObject *)entity result:(BOOL)result{}
+(void)dbWillUpdate:(NSObject *)entity{}

#pragma mark - simplify synchronous function
+(BOOL)checkModelClass:(NSObject*)model
{
    if([model isKindOfClass:self])
        return YES;
    
    NSLog(@"%@ can not use %@",NSStringFromClass(self),NSStringFromClass(model.class));
    return NO;
}

+(int)rowCountWithWhere:(id)where tableName:(NSString*)tableName
{
    return [[self getUsingLKDBHelper] rowCount:self where:where tableName:tableName];
}

+(NSMutableArray*)searchWithWhere:(id)where orderBy:(NSString*)orderBy offset:(int)offset count:(int)count tableName:(NSString*)tableName
{
    return [[self getUsingLKDBHelper] search:self where:where orderBy:orderBy offset:offset count:count tableName:tableName];
}

+(BOOL)insertToDB:(NSObject*)model tableName:(NSString*)tableName
{
    
    if([self checkModelClass:model])
    {
        return [[self getUsingLKDBHelper] insertToDB:model tableName:tableName];
    }
    return NO;
    
}
+(BOOL)insertWhenNotExists:(NSObject*)model tableName:(NSString*)tableName
{
    if([self checkModelClass:model])
    {
        return [[self getUsingLKDBHelper] insertWhenNotExists:model tableName:tableName];
    }
    return NO;
}
+(BOOL)updateToDB:(NSObject *)model where:(id)where tableName:(NSString*)tableName{
    if([self checkModelClass:model])
    {
        return [[self getUsingLKDBHelper] updateToDB:model where:where tableName:tableName];
    }
    return NO;
}
+(BOOL)updateToDBWithSet:(NSString *)sets where:(id)where tableName:(NSString*)tableName
{
    return [[self getUsingLKDBHelper] updateToDB:self set:sets where:where tableName:tableName];
}
+(BOOL)deleteToDB:(NSObject*)model tableName:(NSString*)tableName
{
    if([self checkModelClass:model])
    {
        return [[self getUsingLKDBHelper] deleteToDB:model tableName:tableName];
    }
    return NO;
}
+(BOOL)deleteWithWhere:(id)where tableName:(NSString*)tableName
{
    return [[self getUsingLKDBHelper] deleteWithClass:self where:where tableName:tableName];
}
+(BOOL)isExistsWithModel:(NSObject *)model tableName:(NSString*)tableName
{
    if([self checkModelClass:model])
    {
        return [[self getUsingLKDBHelper] isExistsModel:model tableName:tableName];
    }
    return NO;
}

- (void)saveToDB:(NSString *)tableName
{
    [self.class insertToDB:self tableName:tableName];
}

- (void)deleteToDB:(NSString *)tableName
{
    [self.class deleteToDB:self tableName:tableName];
}

+ (id)searchSingleWithWhere:(id)where orderBy:(NSString*)orderBy tableName:(NSString*)tableName
{
    return [[self getUsingLKDBHelper] searchSingle:self where:where orderBy:orderBy tableName:tableName];
}
@end
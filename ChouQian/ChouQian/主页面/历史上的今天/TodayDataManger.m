//
//  TodayDataManger.m
//  ChouQian
//
//  Created by doujingxuan on 14-5-6.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "TodayDataManger.h"
#import "TodayDataModel.h"
#import "TodayDetailModel.h"


#define TodayTableName @"TodayTableName"

#define TodayDetailTableName @"TodayDetailTableName"

@implementation TodayDataManger

/*作者:窦静轩    描述:返回本地历史上今天的数据*/
+(NSString*)backDayStringByDate:(NSString*)date
{
    NSString * string = nil;
 
    NSString * path =  [LKDBUtils getPathForDocuments:@"Today.db"];
    NSLogDebug(@"path is %@",path);
    LKDBHelper * helper = [[LKDBHelper alloc] initWithDBName:path];
    [helper createTableWithModelClass:[TodayDataModel class] tableName:TodayTableName];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    dict[@"date"] =  date;

    NSArray * sourceArray = [helper search:[TodayDataModel class] where:dict orderBy:nil offset:0 count:MAXFLOAT tableName:TodayTableName];
    if (sourceArray.count > 0) {
        TodayDataModel * model = [sourceArray objectAtIndex:0];
        string = model.todayString;
    }
    
    return string;
}

/*作者:窦静轩    描述:返回本地历史事件详情*/
+(NSString*)backDetailStringByHref:(NSString*)herf
{
    NSString * string = nil;
    
    
    NSString * path =  [LKDBUtils getPathForDocuments:@"Today.db"];
    NSLogDebug(@"path is %@",path);
    
    LKDBHelper * helper = [[LKDBHelper alloc] initWithDBName:path];
    [helper createTableWithModelClass:[TodayDetailModel class] tableName:TodayDetailTableName];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    dict[@"href"] =  herf;
    
    NSArray * sourceArray = [helper search:[TodayDetailModel class] where:dict orderBy:nil offset:0 count:MAXFLOAT tableName:TodayDetailTableName];
    if (sourceArray.count > 0) {
        TodayDetailModel * model = [sourceArray objectAtIndex:0];
        string = model.detailString;
    }

    return string;

}

/*作者:窦静轩    描述:保存本地历史上今天的数据*/
+(BOOL)saveDayStringByDate:(NSString*)date string:(NSString*)string
{
    BOOL success = NO;
    
    NSString * path =  [LKDBUtils getPathForDocuments:@"Today.db"];
    NSLogDebug(@"path is %@",path);
    LKDBHelper * helper = [[LKDBHelper alloc] initWithDBName:path];
    [helper createTableWithModelClass:[TodayDataModel class] tableName:TodayTableName];
    
    TodayDataModel * model = [[TodayDataModel alloc] init];
    model.date = date;
    model.todayString = string;

    success = [helper insertToDB:model tableName:TodayTableName];
   
    return success;
}

/*作者:窦静轩    描述:保存本地历史上今天的数据*/
+(BOOL)saveDayStringByHref:(NSString*)href string:(NSString*)string
{
    BOOL success = NO;
    
    NSString * path =  [LKDBUtils getPathForDocuments:@"Today.db"];
    NSLogDebug(@"path is %@",path);
    LKDBHelper * helper = [[LKDBHelper alloc] initWithDBName:path];
    [helper createTableWithModelClass:[TodayDetailModel class] tableName:TodayDetailTableName];
    
    TodayDetailModel * model = [[TodayDetailModel alloc] init];
    model.href = href;
    model.detailString = string;
    
    success = [helper insertToDB:model tableName:TodayDetailTableName];
    
    return success;

}
@end

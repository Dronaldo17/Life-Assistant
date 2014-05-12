//
//  TodayDataModel.m
//  ChouQian
//
//  Created by doujingxuan on 14-5-6.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "TodayDataModel.h"

@implementation TodayDataModel

+(NSString *)getPrimaryKey
{
    return @"date";
}
+(int)getTableVersion
{
    return 1;
}

@end

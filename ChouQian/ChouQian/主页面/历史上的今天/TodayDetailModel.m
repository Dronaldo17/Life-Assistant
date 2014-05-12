//
//  TodayDetailModel.m
//  ChouQian
//
//  Created by doujingxuan on 14-5-6.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "TodayDetailModel.h"

@implementation TodayDetailModel
+(NSString *)getPrimaryKey
{
    return @"href";
}
+(int)getTableVersion
{
    return 1;
}

@end

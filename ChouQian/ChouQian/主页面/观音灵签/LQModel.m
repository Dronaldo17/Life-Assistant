//
//  LQModel.m
//  ChouQian
//
//  Created by doujingxuan on 14-3-9.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "LQModel.h"

@implementation LQModel

+(NSString *)getPrimaryKey
{
    return @"id";
}
+(int)getTableVersion
{
    return 1;
}

@end

//
//  TodayDataManger.h
//  ChouQian
//
//  Created by doujingxuan on 14-5-6.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodayDataManger : NSObject

/*作者:窦静轩    描述:返回本地历史上今天的数据*/
+(NSString*)backDayStringByDate:(NSString*)date;

/*作者:窦静轩    描述:返回本地历史事件详情*/
+(NSString*)backDetailStringByHref:(NSString*)herf;

/*作者:窦静轩    描述:保存本地历史上今天的数据*/
+(BOOL)saveDayStringByDate:(NSString*)date string:(NSString*)string;

/*作者:窦静轩    描述:保存本地历史上今天的数据*/
+(BOOL)saveDayStringByHref:(NSString*)href string:(NSString*)stringf;

@end

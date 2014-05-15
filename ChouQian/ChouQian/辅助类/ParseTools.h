//
//  ParseTools.h
//  ChouQian
//
//  Created by doujingxuan on 14-3-13.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseTools : NSObject
/*作者:窦静轩    描述:替换字符串A中B字符串并返回替换后的字符串C*/
+(NSString*)replaceAStringbyBStringWithEnter:(NSString*)aString;

/**Author:Ronaldo Description:从本地NSUserDefaults取出值*/
+(id)getValueFromNSUserDefaultsByKey:(NSString*)key;

/**Author:Ronaldo Description:同步NSUserDefaults数据*/
+(void)syncNSUserDeafaultsByKey:(NSString*)key withValue:(id)value;
@end

//
//  ParseTools.m
//  ChouQian
//
//  Created by doujingxuan on 14-3-13.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "ParseTools.h"

@implementation ParseTools
/*作者:窦静轩    描述:替换字符串A中B字符串并返回替换后的字符串C*/
+(NSString*)replaceAStringbyBStringWithEnter:(NSString*)aString
{
    NSString * cSting = nil;
    cSting = [aString stringByReplacingOccurrencesOfString:@"   " withString:@"\r\n"];
    NSLogDebug(@"cSting is %@",cSting);
    return aString;
}
@end

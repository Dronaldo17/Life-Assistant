//
//  TodayDataParse.h
//  ChouQian
//
//  Created by doujingxuan on 14-5-3.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TodayModel;
@class TodayFoucsModel;
@class AFHTTPRequestOperation;
@interface TodayDataParse : NSObject
+(void)todayDataParseByDateSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
+(NSMutableDictionary*)todayDataParse:(NSData*)data;

+(void)parseTodayDetailDataURL:(NSURL*)url  Success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
+(NSMutableDictionary*)parseTodayDetailData:(NSData*)data;

+(NSMutableDictionary*)todayFoucsModelToDict:(TodayFoucsModel*)model;
+(NSMutableDictionary*)todayModelToDict:(TodayModel*)model;
+(TodayModel*)dictToTodayModel:(NSMutableDictionary*)dict;
+(TodayFoucsModel*)dictToTodayFoucsModel:(NSMutableDictionary*)dict;
@end

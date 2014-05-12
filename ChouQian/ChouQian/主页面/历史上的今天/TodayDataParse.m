//
//  TodayDataParse.m
//  ChouQian
//
//  Created by doujingxuan on 14-5-3.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "TodayDataParse.h"
#import "HTMLParser.h"
#import "AFHTTPRequestOperation.h"
#import "TodayFoucsModel.h"
#import "TodayModel.h"
#import "JSONKit.h"


@implementation TodayDataParse
+(void)todayDataParseByDateSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter1 setDateFormat:@"YYYYMMdd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr1 = [dateFormatter1 stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13
    NSLog(@"%@",currentDateStr1);
    
    AVQuery *query = [AVQuery queryWithClassName:TodayModelName];
    [query whereKey:TodayDate equalTo:currentDateStr1];
    AVObject * detailObject =  [query getFirstObject];
    
    NSArray * array1 = [detailObject allKeys];
    NSLogWarn(@"array is %@",array1);
    
    
    NSString * jsonString = [detailObject objectForKeyedSubscript:TodayDataInfo];
    
    NSMutableDictionary * avosDict = [jsonString objectFromJSONString];
    if (avosDict.count>0) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        NSMutableArray * itemsArray = [[NSMutableArray alloc] init];
        NSMutableArray * foucsArray = [[NSMutableArray alloc] init];
        
        
        NSArray * tmpFoucsArray = avosDict[@"foucs"];
        for (int i = 0; i<tmpFoucsArray.count; i++) {
            NSMutableDictionary * dict = [tmpFoucsArray objectAtIndex:i];
            TodayFoucsModel * model = [self dictToTodayFoucsModel:dict];
            [foucsArray addObject:model];
        }
        
        NSArray * tmpItemsArray = avosDict[@"items"];
        for (int i = 0; i<tmpItemsArray.count; i++) {
            NSMutableDictionary * dict = [tmpItemsArray objectAtIndex:i];
            TodayModel * model = [self dictToTodayModel:dict];
            [itemsArray addObject:model];
        }
        
        dict[@"items"] = itemsArray;
        dict[@"foucs"] = foucsArray;
        
        success(nil,dict);
        return;
    }


    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13
    NSLog(@"%@",currentDateStr);
    
    NSArray * array = [currentDateStr componentsSeparatedByString:@"-"];
    
    int month = [array[0] intValue];
    int day = [array[1] intValue];

    NSString * path = [NSString stringWithFormat:@"http://www.todayonhistory.com/%d/%d",month,day];

    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:path] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    [request setHTTPMethod:@"GET"];
    
    AFHTTPRequestOperation * op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
    [op start];

}
+(NSMutableDictionary*)todayDataParse:(NSData*)data
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSMutableArray * items = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray * foucs = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    NSMutableDictionary * avosDict = [NSMutableDictionary dictionary];
    NSMutableArray * avosItems = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray * avosFoucs = [[NSMutableArray alloc] initWithCapacity:0];


    NSError *error;
    
    
    NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //    NSLog(@"html is %@",html);
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error);
    }
    
    HTMLNode *bodyNode = [parser body];
    
    NSArray * foucsNodes = [bodyNode findChildTags:@"div"];
    for (HTMLNode *foucsNode in foucsNodes) {
        if ([[foucsNode getAttributeNamed:@"id"] isEqualToString:@"slideshow"]){
            NSArray * children = [foucsNode findChildTags:@"div"];
            for (HTMLNode * node in children) {
                HTMLNode * lNode = [node findChildTag:@"p"];
                HTMLNode * pNode = [lNode findChildTag:@"a"];
                NSString * href = [pNode getAttributeNamed:@"href"];
                
                HTMLNode * imgSrc = [lNode findChildTag:@"img"];
                NSString * imgURL = [imgSrc getAttributeNamed:@"src"];
                
                NSString * title = [imgSrc getAttributeNamed:@"alt"];
                
                TodayFoucsModel * fModel = [[TodayFoucsModel alloc] init];
                fModel.iconURLString = imgURL;
                fModel.content = title;
                fModel.href = href;
                
                NSMutableDictionary * avosTmpdict  = [self todayFoucsModelToDict:fModel];
                [avosFoucs addObject:avosTmpdict];
                [foucs addObject:fModel];
            }
        }
    }
    
    
    
    NSArray *inputNodes = [bodyNode findChildTags:@"ul"];
    
    for (HTMLNode *inputNode in inputNodes) {
        if ([[inputNode getAttributeNamed:@"class"] isEqualToString:@"list clearfix"]) {
            NSArray * array = [inputNode findChildTags:@"li"];
            for (HTMLNode * liNode in array) {
                
                HTMLNode * node = [liNode firstChild];
                
                NSString * href  =[node getAttributeNamed:@"href"];
                TodayModel * model = [[TodayModel alloc] init];

                if (href.length > 0) {
                   model.href = href;
                }
                else{
                   model.href  = @"";
                }
                
                HTMLNode * timeNode = [liNode findChildTag:@"em"];
                HTMLNode * titleNode = [liNode findChildTag:@"i"];

                model.time = [timeNode allContents];
                model.content = [titleNode allContents];
                
                NSString * rel = [node getAttributeNamed:@"rel"];
                if (rel.length > 0) {
                    model.iconURLString = rel;
                }else{
                    model.iconURLString = @"";
                }
                
                NSMutableDictionary * avosTmpdict  = [self todayModelToDict:model];
                [avosItems addObject:avosTmpdict];
                
                [items addObject:model];
            }
        }
    }
    
    [dict setObject:items forKey:@"items"];
    [dict setObject:foucs forKey:@"foucs"];
    
    [avosDict setObject:avosItems forKey:@"items"];
    [avosDict setObject:avosFoucs forKey:@"foucs"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13
    NSLog(@"%@",currentDateStr);
    
    
    NSString * jsonString1 = [avosDict JSONString];
    
    AVObject *testObject = [AVObject objectWithClassName:TodayModelName];
    [testObject setObject:jsonString1 forKey:TodayDataInfo];
    [testObject setObject:currentDateStr forKey:TodayDate];
    [testObject save];
    
   BOOL success = [TodayDataManger saveDayStringByDate:currentDateStr string:jsonString1];
    if (success) {
        NSLogWarn(@"success");
    }
    return dict;
}
+(void)parseTodayDetailDataURL:(NSURL*)url  Success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AVQuery *query = [AVQuery queryWithClassName:TodayDetailName];
    [query whereKey:TodayHref equalTo:url.absoluteString];
    AVObject * detailObject =  [query getFirstObject];
    
    NSArray * array1 = [detailObject allKeys];
    NSLogWarn(@"array is %@",array1);
    
    
    NSString * jsonString = [detailObject objectForKeyedSubscript:TodayDataInfo];
    
    NSMutableDictionary * avosDict = [jsonString objectFromJSONString];
    if (avosDict.count > 0) {
        success(nil,avosDict);
        return;
    }
    
    if (![url.absoluteString hasPrefix:@"http://"]) {
        NSString * urlString = [NSString stringWithFormat:@"http://www.todayonhistory.com/%@",url.absoluteString];
        NSURL * url1 = [NSURL URLWithString:urlString];
        url = url1;
    }

    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    [request setHTTPMethod:@"GET"];
    
    AFHTTPRequestOperation * op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
         success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
    [op start];


}
+(NSMutableDictionary*)parseTodayDetailData:(NSData*)data
{

    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSMutableArray * items = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray * imgs = [[NSMutableArray alloc] initWithCapacity:0];
    NSError *error;
    
    NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error);
    }
    
    HTMLNode *bodyNode = [parser body];
    

    NSArray * detailP = [bodyNode findChildTags:@"p"];
    
    NSString * string = @"";
    for (HTMLNode *pNode in detailP) {
    
        NSString * contents = [pNode allContents];
        if ([contents hasPrefix:@"Copyright©2004"]) {
            
        }
        else{
            string = [string stringByAppendingFormat:@"%@",contents];
        }
        if ([[pNode getAttributeNamed:@"align"] isEqualToString:@"center"]) {
            HTMLNode * imgNode = [pNode findChildTag:@"img"];
            NSString * picPath = [imgNode getAttributeNamed:@"src"];
            if (picPath.length>0) {
                [imgs addObject:picPath];
            }

        }
        if ([[pNode getAttributeNamed:@"style"] isEqualToString:@"text-align:center"]) {
            HTMLNode * imgNode = [pNode findChildTag:@"img"];
            NSString * picPath = [imgNode getAttributeNamed:@"src"];
            if (picPath.length>0) {
                [imgs addObject:picPath];
            }

        }
        if ([[pNode getAttributeNamed:@"style"] isEqualToString:@"text-align: center"]) {
            HTMLNode * imgNode = [pNode findChildTag:@"img"];
            NSString * picPath = [imgNode getAttributeNamed:@"src"];
            if (picPath.length>0) {
                 [imgs addObject:picPath];
            }
           
        }
    }
    string = [string stringByAppendingString:@"\r\n\r\n"] ;
    [items addObject:string];
    
    dict[@"items"] = items;
    dict[@"imgs"] = imgs;
    
    
//    NSString * jsonString1 = [dict JSONString];
//    
//    AVObject *testObject = [AVObject objectWithClassName:TodayModelName];
//    [testObject setObject:jsonString1 forKey:TodayDetailInfo];
//    [testObject setObject:currentDateStr1 forKey:TodayDate];
//    [testObject save];

    return dict;
}
+(NSMutableDictionary*)todayFoucsModelToDict:(TodayFoucsModel*)model
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"iconURL"] = model.iconURLString;
    dict[@"href"] = model.href;
    dict[@"content"] = model.content;
    return dict;
}
+(NSMutableDictionary*)todayModelToDict:(TodayModel*)model
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"iconURL"] = model.iconURLString;
    dict[@"time"] = model.time;
    dict[@"content"] = model.content;
    dict[@"href"] = model.href;
    return dict;
}
+(TodayModel*)dictToTodayModel:(NSMutableDictionary*)dict
{
    TodayModel * model = [[TodayModel alloc] init];
    model.iconURLString = dict[@"iconURL"];
    model.href = dict[@"href"];
    model.time = dict[@"time"];
    model.content = dict[@"content"];
    return model;
}
+(TodayFoucsModel*)dictToTodayFoucsModel:(NSMutableDictionary*)dict
{
    TodayFoucsModel * model = [[TodayFoucsModel alloc] init];
    model.iconURLString =  dict[@"iconURL"];
    model.content = dict[@"content"];
    model.href=  dict[@"href"] ;
    return model;
}

@end

//
//  Logger.h
//  XFTIOSClinet
//
//  Created by doujingxuan on 13-11-11.
//  Copyright (c) 2013年 doujingxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Logger : NSObject
enum LogLevel{
    LogNone = 0,
    LogError,
    LogWarn,
    LogInfo,
    LogDebug,
};


/**
 * get / set the log level
 **/
extern enum LogLevel GetLogLevel();
extern void SetLogLevel(enum LogLevel level);

/**
 *  log message
 **/
extern void NSLogError(NSString *format,...);
extern void NSLogWarn(NSString *format,...);
extern void NSLogInfo(NSString *format,...);
extern void NSLogDebug(NSString *format,...);
@end

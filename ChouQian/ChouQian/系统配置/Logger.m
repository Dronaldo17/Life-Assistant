//
//  Logger.m
//  XFTIOSClinet
//
//  Created by doujingxuan on 13-11-11.
//  Copyright (c) 2013年 doujingxuan. All rights reserved.
//

#import "Logger.h"

@implementation Logger
static enum LogLevel currentLevel = LogDebug;

enum LogLevel GetLogLevel(){
    return currentLevel;
}

void SetLogLevel(enum LogLevel level){
    currentLevel = level;
}


void NSLogError(NSString *format,...){
    
    // check level to determine whether we need to log message
    if (currentLevel < LogError) {
        return;
    }
    
    // log message
    va_list argList;
    va_start(argList,format);
    
    NSLogv(format,argList);
    
    va_end(argList);
    
}

void NSLogWarn(NSString *format,...){
    
    // check level to determine whether we need to log message
    if (currentLevel < LogWarn) {
        return;
    }
    
    // log message
    va_list argList;
    va_start(argList,format);
    
    NSLogv(format,argList);
    
    va_end(argList);
    
}

void NSLogInfo(NSString *format,...){
    
    // check level to determine whether we need to log message
    if (currentLevel < LogInfo) {
        return;
    }
    // log message
    va_list argList;
    va_start(argList,format);
    
    NSLogv(format,argList);
    
    va_end(argList);
    
}

void NSLogDebug(NSString *format,...){
    
    // check level to determine whether we need to log message
    if (currentLevel < LogDebug) {
        return;
    }
    // log message
    va_list argList;
    va_start(argList,format);
    
    NSLogv(format,argList);
    
    va_end(argList);
    
}


@end

//
//  config.m
//  uimain
//
//  Created by doujingxuan on 3/29/12.
//  Copyright (c) 2012 doujingxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Logger.h"
#import "SysConfig.h"

// current enviroment
static enum SysEnv _currentEnv = SysDev;

// define configuration structure
struct SysConfig {
    enum LogLevel logLevel;
    char currentVersonNumber[16];
};


// configurations for different environments
struct SysConfig  _configureArray[SysEnvEnd] = {
    
    // for SysDev
    {
        .logLevel = LogDebug,
        .currentVersonNumber = "1.0",
    },
    
    // for SysQa
    {
        .logLevel = LogWarn,
        .currentVersonNumber = "1.0",
    },
    
    // for SysProd
    {
        .logLevel = LogNone,
        .currentVersonNumber = "1.0",
    }

};
@implementation SysConfig

+ (enum SysEnv) getSysEnv{
    return _currentEnv;
}

+ (void) setSysEnv:(enum SysEnv) env {
    _currentEnv = env;
}

+ (struct SysConfig) getCurrentConfig {
    return _configureArray[_currentEnv];
}

+ (struct SysConfig*) getCurrentConfigPointer {
    return &_configureArray[_currentEnv];
}
float OSVersion() {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
@end





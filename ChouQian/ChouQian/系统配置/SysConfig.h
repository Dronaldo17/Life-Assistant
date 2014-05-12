//
//  config.h
//  uimain
//
//  Created by doujingxuan on 3/29/12.
//  Copyright (c) 2012 doujingxuan. All rights reserved.
//

enum SysEnv {SysDev, SysQa, SysProd, SysEnvEnd};

@interface SysConfig : NSObject

// configure the system runtime environments
+ (enum SysEnv) getSysEnv;
+ (void) setSysEnv:(enum SysEnv) env;

float OSVersion();
@end

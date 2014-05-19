//
//  main.m
//  ChouQian
//
//  Created by doujingxuan on 14-3-7.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SysConfig.h"

int main(int argc, char * argv[])
{
    [SysConfig setSysEnv:SysProd];
    SetLogLevel(LogError);
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

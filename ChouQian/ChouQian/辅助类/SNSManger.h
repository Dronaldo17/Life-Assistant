//
//  SNSManger.h
//  ChouQian
//
//  Created by doujingxuan on 14-5-12.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNSManger : NSObject

+(void)ShowSNSPlatforms:(NSArray*)platforms  supportedInterfaceOrientations:(NSInteger)orientations
      isStatusBarHidden:(BOOL)isHidden
       targetViewForPad:(UIView *)targetView
         cancelListener:(FrontiaShareCancelCallback)onCancel
        failureListener:(FrontiaShareFailureCallback)onFailure
         resultListener:(FrontiaMultiShareResultCallback)onResult
    frontiaShareContent:(FrontiaShareContent*)frontiaShareContent;
@end

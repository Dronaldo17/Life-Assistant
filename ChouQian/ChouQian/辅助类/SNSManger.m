//
//  SNSManger.m
//  ChouQian
//

//showShareMenuWithShareContent:content displayPlatforms:platforms supportedInterfaceOrientations:UIInterfaceOrientationMaskPortrait isStatusBarHidden:NO targetViewForPad:sender cancelListener:onCancel failureListener:onFailure resultListener:onResult];

//  Created by doujingxuan on 14-5-12.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "SNSManger.h"

@implementation SNSManger
+(void)ShowSNSPlatforms:(NSArray*)platforms  supportedInterfaceOrientations:(NSInteger)orientations
          isStatusBarHidden:(BOOL)isHidden
           targetViewForPad:(UIView *)targetView
             cancelListener:(FrontiaShareCancelCallback)onCancel
            failureListener:(FrontiaShareFailureCallback)onFailure
             resultListener:(FrontiaMultiShareResultCallback)onResult
        frontiaShareContent:(FrontiaShareContent*)frontiaShareContent
{
    FrontiaShare *share = [Frontia getShare];
    
    [share showShareMenuWithShareContent:frontiaShareContent displayPlatforms:platforms supportedInterfaceOrientations:UIInterfaceOrientationMaskPortrait isStatusBarHidden:NO targetViewForPad:targetView cancelListener:onCancel failureListener:onFailure resultListener:onResult];
}
@end

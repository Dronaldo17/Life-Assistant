//
//  ZhuShouAdView.h
//  ChouQian
//
//  Created by doujingxuan on 14-5-14.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouMiView.h"
#import "GADBannerView.h"

@interface ZhuShouAdView : UIView<YouMiDelegate,GADBannerViewDelegate>
-(id)initWithAdView:(UIView*)bottomView controller:(UIViewController*)controller;
@end

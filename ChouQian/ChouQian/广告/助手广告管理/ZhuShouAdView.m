//
//  ZhuShouAdView.m
//  ChouQian
//
//  Created by doujingxuan on 14-5-14.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "ZhuShouAdView.h"

@implementation ZhuShouAdView
-(id)initWithAdView:(UIView*)bottomView controller:(UIViewController*)controller
{
    self = [super init];
    if (self) {
        int num = arc4random();
        if (num % 2 == 0) {
            YouMiView *adView320x50=[[YouMiView alloc] initWithContentSizeIdentifier:YouMiBannerContentSizeIdentifier320x50 delegate:self];
            [adView320x50 start];
            [self addSubview:adView320x50];
        }
        else
        {
          GADBannerView *  bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
            bannerView.delegate = self;
            bannerView.adUnitID = GoogleSDKPub_ID;
            bannerView.rootViewController = controller;
            
            [bannerView loadRequest:[GADRequest request]];
            self = bannerView;
        }
    }

    return self;
}

#pragma mark 有米广告回调
- (void)didReceiveAd:(YouMiView *)adView {
    NSLogDebug(@"有米获得广告");
}

- (void)didFailToReceiveAd:(YouMiView *)adView  error:(NSError *)error {
    NSLogDebug(@"有米获取广告失败");
}

- (void)willPresentScreen:(YouMiView *)adView {
    NSLogDebug(@"有米将要显示全屏广告");
    
}

- (void)didPresentScreen:(YouMiView *)adView {
    NSLogDebug(@"有米已显示全屏广告");
}

- (void)willDismissScreen:(YouMiView *)adView {
    NSLogDebug(@"有米将要退出全屏广告");
    
}

- (void)didDismissScreen:(YouMiView *)adView {
    NSLogDebug(@"有米取消全屏广告");
}


#pragma mark google 广告添加
- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    NSLogDebug(@"google adViewDidReceiveAd");
    
}
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLogDebug(@"google didFailToReceiveAdWithError is %@",[error description]);
    
    
}
- (void)adViewWillPresentScreen:(GADBannerView *)adView
{
    NSLogDebug(@"google adViewWillPresentScreen");
    
}
- (void)adViewWillDismissScreen:(GADBannerView *)adView
{
    NSLogDebug(@"google adViewWillDismissScreen");
    
}
- (void)adViewDidDismissScreen:(GADBannerView *)adView
{
    NSLogDebug(@"google adViewDidDismissScreen");
    
}
- (void)adViewWillLeaveApplication:(GADBannerView *)adView
{
    NSLogDebug(@"google adViewWillLeaveApplication");
    
}

@end

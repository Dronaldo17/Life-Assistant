//
//  MobiSageSDK.h
//  Adv_SDK_Demo
//
//  Created by yunjie on 13-4-26.
//  Copyright (c) 2013年 stick. All rights reserved.
//


#define MS_Default_PublishID            @"566786fdeb8e46c6bf3d45a30cf3708a"  //省心闹钟用的pid
#define MS_OfferWall_PublishID          @"a8300de238a94ae0a7788e75b56d938b"  //积分墙的pid

#define SDK_RunMode_Test                @"http://dev.adsage.tk/sdkjs/adv/index.html"
#define SDK_RunMode_Branch              @"http://dev.adsage.tk/sdkjs/adv/index.html?cc=false&local=true"
#define SDK_RunMode_UnitTest            @"http://dev.adsage.tk/sdkjs/tests/tester.html"
#define SDK_RunMode_HTMLIntervalTest    @"http://dev.adsage.tk/sdkjs/tests/index-test.html"

#define SDK_RunMode_Mock  @"http://dev.adsage.tk/sdkjs/adv/index.html?mock=true"
#define SDK_RunMode_CC    @"http://dev.adsage.tk/sdkjs/adv/index.html?cc=true"
#define SDK_RunMode_Zip   @"http://dev.adsage.tk/sdkjs/adv-min/index.html"


#pragma Size_List
#define Banner_iphone                           1       //for iphone    320X50
#define Banner_ipad                             2       //for ipad      728X90
#define Default_size                            0       //for default

#pragma Splash Orientation
#define MS_Orientation_Portrait                 1
#define MS_Orientation_Landscape                2


//广告轮换方式
typedef enum
{
    noAnime     = -1,
    Random      = 1,
    Fade        = 2,
    FlipL2R     = 3,
    FlipT2B     = 4,
    CubeT2B     = 5,
    CubeL2R     = 6,
    Ripple      = 7,
    PageCurl    = 8,
    PageUnCurl  = 9,
} MobiSageAnimeType;

#pragma Ad_Interval
typedef enum
{
    Ad_NO_Refresh = 0,
    Ad_Refresh_30 = 4,
    Ad_Refresh_60 = 5,
}MSAdRefreshInterval;

@interface MobiSageManager : NSObject
{
    
}

/**
 *  @brief 获得MobiSage平台管理单例
 */
+ (MobiSageManager*)getInstance;

/**
 *  @brief 设置publisherID
 *  @param publisherID 开发者平台分配给应用的id
 */
- (void)setPublisherID:(NSString*)publisherID;

/**
 *  @brief 设置应用分发渠道
 *  @param deployChannel 分发渠道名称
 */
- (void)setPublisherID:(NSString*)publisherID deployChannel:(NSString*)deployChannel;

/**
 *  @brief 设置是否在应用内打开app store（使用store kit）
 *  @param flag YES在应用内打开，否则在应用外打开
 *  @note  在IOS7下，只支持横屏的应用内打开app store组件，应用会崩溃
 */
- (void)showStoreInApp:(BOOL)flag;

/**
 *  @brief 销毁管理单例
 *  @note  单例的生成和销毁动作占用资源较大，不建议经常调用
 */
+ (void)destroyInstance;
@end



#pragma MobiSageBanner
@class MobiSageBanner;

@protocol MobiSageBannerDelegate

@optional

- (void)mobiSageBannerClick:(MobiSageBanner*)adBanner;

- (void)mobiSageBannerClose:(MobiSageBanner*)adBanner;

- (void)mobiSageBannerSuccessToRequest:(MobiSageBanner*)adBanner;

- (void)mobiSageBannerFaildToRequest:(MobiSageBanner*)adBanner;

- (void)mobiSageBannerSuccessToShowAd:(MobiSageBanner*)adBanner;

- (void)mobiSageBannerFaildToShowAd:(MobiSageBanner*)adBanner;

- (void)mobiSageBannerLandingSitShow:(MobiSageBanner*)adBanner;

- (void)mobiSageBannerLandingSitClose:(MobiSageBanner*)adBanner;

@end


@interface MobiSageBanner : UIView

- (id)initWithDelegate:(id<MobiSageBannerDelegate>)delegate;

- (id)initWithDelegate:(id<MobiSageBannerDelegate>)delegate
                adSize:(NSUInteger)adSize;

- (id)initWithDelegate:(id<MobiSageBannerDelegate>)delegate
                adSize:(NSUInteger)adSize
          intervalTime:(int)intervalTime
       switchAnimeType:(int)animeType;
@end


#pragma MobiSageFloatWindow
@class MobiSageFloatWindow;

@protocol MobiSageFloatWindowDelegate

@optional

- (void)mobiSageBannerClick:(MobiSageFloatWindow*)adBanner;

- (void)mobiSageBannerClose:(MobiSageFloatWindow*)adBanner;

- (void)mobiSageBannerSuccessToRequest:(MobiSageFloatWindow*)adBanner;

- (void)mobiSageBannerFaildToRequest:(MobiSageFloatWindow*)adBanner;

- (void)mobiSageBannerLandingSitShow:(MobiSageFloatWindow*)adBanner;

- (void)mobiSageBannerLandingSitClose:(MobiSageFloatWindow*)adBanner;

@end


@interface MobiSageFloatWindow : UIView

- (id)initWithDelegate:(id<MobiSageFloatWindowDelegate>)delegate;

- (void)showAdvView;

@end


#pragma MobiSageSplash

@class MobiSageSplash;

@protocol MobiSageSplashDelegate
@optional
/**
 *  AdSplash展示成功
 *  @param adSplash
 */
- (void)mobiSageSplashSuccessToShow:(MobiSageSplash*)adSplash;

/**
 *  AdSplash展示失败
 *  @param adSplash
 */
- (void)mobiSageSplashFaildToRequest:(MobiSageSplash*)adSplash;

/**
 *  AdSplash被点击
 *  @param adSplash
 */
- (void)mobiSageSplashClick:(MobiSageSplash*)adSplash;

/**
 *  AdSplash被关闭
 *  @param adSplash
 */
- (void)mobiSageSplashClose:(MobiSageSplash*)adSplash;
@end

@interface MobiSageSplash : UIView
{
    id<MobiSageSplashDelegate> adviewDelegate;
}
- (id)initWithOrientation:(NSInteger)screenOrientation
               background:(UIColor*)bgColor
             withDelegate:(id<MobiSageSplashDelegate>)delegate;

- (void)startSplash;
@end


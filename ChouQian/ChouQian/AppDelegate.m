//
//  AppDelegate.m
//  ChouQian
//
//  Created by doujingxuan on 14-3-7.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"
#import "LQViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    /*作者:窦静轩    描述:AVOS的加载*/
    [self addAVOS];
    
    /*作者:窦静轩    描述:添加Umeng统计*/
    [self addUmeng];
    
    /*作者:窦静轩    描述:添加广告*/
    [self addADViews];
    
    /*作者:窦静轩    描述:加载Menu*/
    [self addMenu];
    
    /*作者:窦静轩    描述:加载SNS分享*/
    [self addSNS];
  
    /*作者:窦静轩    描述:加载过渡图片*/
    [self addSplashScreen];
    
     return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController");
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController");
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController");
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController");
}
/**Author:Ronaldo Description:添加过渡动画*/
-(void)addSplashScreen
{
    UIImageView *splashScreen = [[UIImageView alloc] initWithFrame:self.window.bounds] ;
    splashScreen.image = [UIImage imageNamed:@"Default"];
    [self.window addSubview:splashScreen];
    
    [UIView animateWithDuration:2.0 animations:^{
        CATransform3D transform = CATransform3DMakeScale(1.5, 1.5, 1.0);
        splashScreen.layer.transform = transform;
        splashScreen.alpha = 0.0;
    } completion:^(BOOL finished) {
        [splashScreen removeFromSuperview];
    }];
}
-(void)addAVOS
{
    [AVOSCloud setApplicationId:AVOSClientID
                      clientKey:AVOSAppKey];
}
-(void)addMenu
{
    // Override point for customization after application launch.
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[LQViewController alloc] init]];
    MenuViewController *menuViewController = [[MenuViewController alloc] init];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController menuViewController:menuViewController];
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"MenuBackground"];
    sideMenuViewController.delegate = self;
    self.window.rootViewController = sideMenuViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

}
-(void)addSNS
{
    
//    NSArray *platforms = [NSArray arrayWithObjects:kBD_SOCIAL_SHARE_PLATFORM_SINAWEIBO,kBD_SOCIAL_SHARE_PLATFORM_QQWEIBO,kBD_SOCIAL_SHARE_PLATFORM_QQZONE,kBD_SOCIAL_SHARE_PLATFORM_WEIXIN_SESSION,kBD_SOCIAL_SHARE_PLATFORM_WEIXIN_TIMELINE,kBD_SOCIAL_SHARE_PLATFORM_QQFRIEND,
//                          kBD_SOCIAL_SHARE_PLATFORM_EMAIL,
//                          kBD_SOCIAL_SHARE_PLATFORM_SMS,nil];
//    //初始化分享组件
//    [BDSocialShareSDK registerApiKey:Baidu_App_Key andSupportPlatforms:platforms];

    
    
    [Frontia initWithApiKey:BaiduSNS_API_Key];
    FrontiaShare *share = [Frontia getShare];
    NSArray * platforms = [NSArray arrayWithObjects:FRONTIA_SOCIAL_SHARE_PLATFORM_SINAWEIBO,FRONTIA_SOCIAL_SHARE_PLATFORM_WEIXIN_SESSION,FRONTIA_SOCIAL_SHARE_PLATFORM_WEIXIN_TIMELINE,FRONTIA_SOCIAL_SHARE_PLATFORM_EMAIL,FRONTIA_SOCIAL_SHARE_PLATFORM_SMS,nil];
    
    [share setSupportPlatforms:platforms];
    
    [share registerSinaweiboAppId:Sina_App_Key];
    
    [share registerWeixinAppId:WeiXin_App_ID];
    
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    FrontiaShare *share = [Frontia getShare];
    return [share handleOpenURL:url];
}
-(void)addUmeng
{
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:REALTIME channelId:@"Debug"];
}
-(void)addADViews
{
    if ([isVerty intValue] == 1) {
        return ;
    }

    [YouMiConfig launchWithAppID:YouMi_Publish_ID appSecret:YouMi_Secret];
}
@end

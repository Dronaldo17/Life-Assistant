//
//  LQViewController.m
//  ChouQian
//
//  Created by doujingxuan on 14-3-9.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "LQViewController.h"
#import "LQModel.h"
#import "BTGlassScrollView.h"

#define Last_ChouQianDate @"Last_ChouQianDate"

#define Last_ChouQianNumber @"Last_ChouQianNumber"

@interface LQViewController ()
{
    LKDBHelper * _help;
    LQModel * _model;
}
@end

@implementation LQViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _glassScrollView = [[BTGlassScrollView alloc] initWithFrame:self.view.frame BackgroundImage:image blurredImage:nil viewDistanceFromBottom:400 foregroundView:[self customView]];
        [self createBanner];
        [self.view addSubview:_glassScrollView];
    }
    return self;
}


- (void)viewDidLoad
{
    self.title = @"观音灵签";
    self.leftButtonShow = YES;
    [super viewDidLoad];
    
    //white status bar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //preventing weird inset
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    
    LKDBHelper *  help =  [[LKDBHelper alloc] initWithDBName:@"lingqian"];
    [help createTableWithModelClass:[LQModel class]tableName:@"lingqianSimple"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    int radomNumber = 0;
    NSDate * lastDate = [ParseTools getValueFromNSUserDefaultsByKey:Last_ChouQianDate];
    if (nil == lastDate) {
        lastDate = [NSDate date];
        [ParseTools syncNSUserDeafaultsByKey:Last_ChouQianDate withValue:lastDate];
    }
    NSTimeInterval interval = abs((int)[lastDate timeIntervalSinceNow]);
    NSLogWarn(@"interval is %f",interval);
    
    if (interval < (60*60*24) && interval > 0) {
        NSNumber * number = [ParseTools getValueFromNSUserDefaultsByKey:Last_ChouQianNumber];
        if (number.intValue<=0) {
            radomNumber = arc4random() % 100 + 1;
            NSNumber * number = [NSNumber numberWithInt:radomNumber];
            [ParseTools syncNSUserDeafaultsByKey:Last_ChouQianNumber withValue:number];
        }
        else{
            radomNumber = number.intValue;
        }
    }
    else{
         radomNumber = arc4random() % 100 + 1;
        NSNumber * number = [NSNumber numberWithInt:radomNumber];
        [ParseTools syncNSUserDeafaultsByKey:Last_ChouQianNumber withValue:number];
    }

   
    dict[@"id"] = [NSString stringWithFormat:@"%d",radomNumber];
    NSArray * sourceArray = [help search:[LQModel class] where:dict orderBy:nil offset:0 count:MAXFLOAT tableName:@"lingqianSimple"];
    _model = [[LQModel alloc] init];
    _model = [sourceArray objectAtIndex:0];
    NSLogDebug(@"sourceArray is %@",[[sourceArray objectAtIndex:0] jixiong]);
    [self createButton];
}
-(void)createBanner
{
   ZhuShouAdView * adView = [[ZhuShouAdView alloc] initWithAdView:_glassScrollView controller:self];
    CGFloat statusHeight  = 20;
    CGFloat navHeight = 44;
    CGFloat top = [UIScreen mainScreen].bounds.size.height - CGRectGetHeight(adView.bounds) - statusHeight - navHeight;
    adView.frame = CGRectMake(0,top, CGRectGetWidth(adView.bounds), CGRectGetHeight(adView.bounds));
    adView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    [_glassScrollView addSubview:adView];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = NavBackGroundColor;

}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //reset offset when rotate
    [_glassScrollView scrollVerticallyToOffset:-_glassScrollView.foregroundScrollView.contentInset.top];
    
}

- (void)viewWillLayoutSubviews
{
    [_glassScrollView setTopLayoutGuideLength:[self.topLayoutGuide length]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIView *)customView
{
    CGFloat _tempHeight = 0;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    
    UIView * whatQianView = [UITools createBlackRoundsByString:[NSString stringWithFormat:@"%@",_model.jixiong] font:HelveticFont_(60)];
    whatQianView.left = 10;
    _tempHeight += whatQianView.height+30;
    whatQianView.backgroundColor = [UIColor clearColor];
    [view addSubview:whatQianView];
    
    UIView  * titleView = [UITools createBlackRoundsByString:[NSString stringWithFormat:@"%@ %@\n宫位：%@",_model.lingqian,_model.diangu,_model.gongwei] font:HelveticFont_(24)];
    titleView.top = _tempHeight;
    titleView.left = 10;
    _tempHeight += titleView.height +30;
    titleView.backgroundColor = [UIColor clearColor];
    [view addSubview:titleView];
    
    
    UIView  * shiyueView2 = [UITools createBlackRoundsByString:[NSString stringWithFormat:@"诗曰\r\n%@",_model.shiyue] font:HelveticFont_(28)];
    shiyueView2.top = _tempHeight;
    shiyueView2.left = 10;
    _tempHeight += shiyueView2.height +30;
    shiyueView2.backgroundColor = [UIColor clearColor];
    [view addSubview:shiyueView2];


    UIView  * shiyueView = [UITools createBlackRoundsByString:[NSString stringWithFormat:@"签语\r\n%@",_model.qianyu] font:HelveticFont_(26)];
    shiyueView.top = _tempHeight;
    shiyueView.left = 10;
    _tempHeight += shiyueView.height +30;
    shiyueView.backgroundColor = [UIColor clearColor];
    [view addSubview:shiyueView];
    
    UIView  * shiyueView3 = [UITools createBlackRoundsByString:[NSString stringWithFormat:@"解签\r\n%@",_model.jieqian] font:HelveticFont_(26)];
    shiyueView3.top = _tempHeight;
    shiyueView3.left = 10;
    _tempHeight += shiyueView3.height +30;
    shiyueView3.backgroundColor = [UIColor clearColor];
    [view addSubview:shiyueView3];

    view.height = _tempHeight+50;
    return view;
}
-(void)rightButtonClicked:(id)sender
{
    //授权取消回调函数
    FrontiaShareCancelCallback onCancel = ^(){
        NSLogDebug(@"OnCancel: share is cancelled");
    };
    
    //授权失败回调函数
    FrontiaShareFailureCallback onFailure = ^(int errorCode, NSString *errorMessage){
        NSLogDebug(@"OnFailure: %d  %@", errorCode, errorMessage);
    };
    
    //授权成功回调函数
    FrontiaMultiShareResultCallback onResult = ^(NSDictionary *respones){
        NSLogDebug(@"OnResult: %@", [respones description]);
    };
    
    FrontiaShareContent *content=[[FrontiaShareContent alloc] init];
    content.url = @"http://www.baidu.com";
    content.title = @"生活助手";
    content.description = @"出门前 抽个签看看运势？看看我他（她）的星座合不合得来？看看历史上的今天发生过什么事情 一切尽在生活必备助手 生活必备助手 让您的生活 变得更美";
    UIGraphicsBeginImageContext(self.view.frame.size); //currentView 当前的view
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    content.imageObj = viewImage;
    
    NSArray *platforms = @[FRONTIA_SOCIAL_SHARE_PLATFORM_SINAWEIBO,FRONTIA_SOCIAL_SHARE_PLATFORM_WEIXIN_SESSION,FRONTIA_SOCIAL_SHARE_PLATFORM_WEIXIN_TIMELINE,FRONTIA_SOCIAL_SHARE_PLATFORM_EMAIL,FRONTIA_SOCIAL_SHARE_PLATFORM_SMS];
    [SNSManger ShowSNSPlatforms:platforms supportedInterfaceOrientations:UIInterfaceOrientationMaskPortrait isStatusBarHidden:NO targetViewForPad:self.view cancelListener:onCancel failureListener:onFailure resultListener:onResult frontiaShareContent:content];
}
-(void)createButton
{
    UIButton * backButton =[UITools createBarButtonWithObject:PNGIMAGE(@"icon_more_share_n@2x") andWithLeft:NO];
    [backButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.rightBarButtonItem = barButton;

}
-(void)backButtonClicked:(id)sender
{
    [self.sideMenuViewController presentMenuViewController]
    ;
}

#pragma youmidelegate

@end

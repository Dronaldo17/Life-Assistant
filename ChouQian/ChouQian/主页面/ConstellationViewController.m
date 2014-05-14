//
//  ConstellationViewController.m
//  ChouQian
//
//  Created by doujingxuan on 14-4-24.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "ConstellationViewController.h"
#import "ConstellationModel.h"

@interface ConstellationViewController ()
{
    ConstellationModel * _model;
}
@end

@implementation ConstellationViewController

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
    
    [self loadData];
    
    UIImage * image = PNGIMAGE(@"MenuBackground@2x");
    
    _glassScrollView = [[BTGlassScrollView alloc] initWithFrame:self.view.frame BackgroundImage:image blurredImage:nil viewDistanceFromBottom:400 foregroundView:[self customView]];
    [self createBanner];
    
    [self.view addSubview:_glassScrollView];
    [self createButton];
}

- (void)viewWillAppear:(BOOL)animated
{

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
    
    UIView * whatQianView1 = [UITools createBlackRoundsByString:[NSString stringWithFormat:@"%@ VS %@",self.f_AstroName1,self.f_AstroName2] font:HelveticFont_(30)];
    whatQianView1.left = 10;
    _tempHeight += whatQianView1.height+20;
    whatQianView1.backgroundColor = [UIColor clearColor];
    [view addSubview:whatQianView1];

    UIView * whatQianView = [UITools createBlackRoundsByString:@"指数" font:HelveticFont_(40)];
    whatQianView.left = 10;
    whatQianView.top = _tempHeight;
    _tempHeight += whatQianView.height+30;
    whatQianView.backgroundColor = [UIColor clearColor];
    [view addSubview:whatQianView];
    
    UIView  * titleView = [UITools createBlackRoundsByString:_model.f_Description1 font:HelveticFont_(24)];
    titleView.top = _tempHeight;
    titleView.left = 10;
    _tempHeight += titleView.height +30;
    titleView.backgroundColor = [UIColor clearColor];
    [view addSubview:titleView];
    
    
    UIView  * shiyueView2 = [UITools createBlackRoundsByString:@"详解" font:HelveticFont_(28)];
    shiyueView2.top = _tempHeight;
    shiyueView2.left = 10;
    _tempHeight += shiyueView2.height +30;
    shiyueView2.backgroundColor = [UIColor clearColor];
    [view addSubview:shiyueView2];
    
    
    UIView  * shiyueView = [UITools createBlackRoundsByString:_model.f_Description2 font:HelveticFont_(26)];
    shiyueView.top = _tempHeight;
    shiyueView.left = 10;
    _tempHeight += shiyueView.height;
    shiyueView.backgroundColor = [UIColor clearColor];
    [view addSubview:shiyueView];
    
    view.height = _tempHeight+100;
    return view;
}
-(void)loadData
{
    LKDBHelper *  help =  [[LKDBHelper alloc] initWithDBName:@"xingzuo"];
    [help createTableWithModelClass:[ConstellationModel class]tableName:@"t_xingzuo_match_lib"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    dict[@"f_AstroName1"] = self.f_AstroName1;
    dict[@"f_AstroName2"] = self.f_AstroName2;
    NSArray * sourceArray = [help search:[ConstellationModel class] where:dict orderBy:nil offset:0 count:MAXFLOAT tableName:@"t_xingzuo_match_lib"];
    if (sourceArray.count == 0) {
        dict[@"f_AstroName2"] = self.f_AstroName1;
        dict[@"f_AstroName1"] = self.f_AstroName2;
        sourceArray = [help search:[ConstellationModel class] where:dict orderBy:nil offset:0 count:MAXFLOAT tableName:@"t_xingzuo_match_lib"];
    }
    if (sourceArray.count<1) {
        [UITools alertShow:@"暂无数据"];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    _model = [[ConstellationModel alloc] init];
    _model = [sourceArray objectAtIndex:0];
    NSLogDebug(@"f_Description1 is %@",_model.f_Description1);
    NSLogDebug(@"f_Description2 is %@",_model.f_Description2);
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


@end

//
//  ChineseZodiacController.m
//  ChouQian
//
//  Created by doujingxuan on 14-3-21.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "ChineseZodiacController.h"
#import "ChineseZodiacModel.h"
#import "iOSCombobox.h"
#import "BSKeyboardControls.h"

@interface ChineseZodiacController ()<iOSComboboxDelegate,BSKeyboardControlsDelegate>
{
    ChineseZodiacModel * _model;
}
@property (nonatomic, strong) BSKeyboardControls *keybc;
@end


@implementation ChineseZodiacController

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
    self.title = @"生肖配对";
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
    
    UIView * whatQianView = [UITools createBlackRoundsByString:[NSString stringWithFormat:@"%@",_model.jieguo] font:HelveticFont_(24)];
    whatQianView.left = 10;
    _tempHeight += whatQianView.height+50;
    whatQianView.backgroundColor = [UIColor clearColor];
    [view addSubview:whatQianView];
   
    view.height = _tempHeight+50;
    return view;
}
-(void)loadData
{
    LKDBHelper *  help =  [[LKDBHelper alloc] initWithDBName:@"shengxiao"];
    [help createTableWithModelClass:[ChineseZodiacModel class]tableName:@"shenXiaoPei"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    dict[@"shenxiao1"] = self.shengxiao1;
    dict[@"shenxiao2"] = self.shengxiao2;
    NSArray * sourceArray = [help search:[ChineseZodiacModel class] where:dict orderBy:nil offset:0 count:MAXFLOAT tableName:@"shenXiaoPei"];
    if (sourceArray.count == 0) {
        dict[@"shenxiao2"] = self.shengxiao1;
        dict[@"shenxiao1"] = self.shengxiao2;
        sourceArray = [help search:[ChineseZodiacModel class] where:dict orderBy:nil offset:0 count:MAXFLOAT tableName:@"shenXiaoPei"];
    }
    if (sourceArray.count<1) {
        [UITools alertShow:@"暂无数据"];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    _model = [[ChineseZodiacModel alloc] init];
    _model = [sourceArray objectAtIndex:0];
    NSLogDebug(@"sourceArray is %@",[[sourceArray objectAtIndex:0] jieguo]);
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
    content.url = APP_STORE_URL;
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

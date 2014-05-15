//
//  HistoryDetailViewController.m
//  ChouQian
//
//  Created by doujingxuan on 14-5-4.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "HistoryDetailViewController.h"
#import "AFHTTPRequestOperation.h"
#import "TodayDataParse.h"

#define TodayImageleft 10

#define TodayImageWigth 300

#define TodayImageHeight 200

#define TodayBaseTag 1000

@interface HistoryDetailViewController ()
{
    NSMutableArray * _imgs;
    NSMutableArray * _items;
}
@end

typedef void(^GetTodayDataSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);

typedef void(^GetTodayDataFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@implementation HistoryDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    self.title = @"详情";
    self.leftButtonShow = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];

    UIImage * image = [UIImage imageNamed:@"MenuBackground"];

    _glassScrollView = [[BTGlassScrollView alloc] initWithFrame:self.view.frame BackgroundImage:image blurredImage:nil viewDistanceFromBottom:400 foregroundView:[self customView]];
    [self createBanner];
    [self.view addSubview:_glassScrollView];
    [self createButton];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (UIView *)customView
{
    CGFloat _tempHeight = 0;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    for (int i = 0; i<_imgs.count; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(TodayImageleft, _tempHeight, TodayImageWigth, TodayImageHeight)];
        NSURL * url = [NSURL URLWithString:[_imgs objectAtIndex:i]];
        [imageView setImageWithURL:url placeholderImage:PNGIMAGE(@"PhotoDownloadfailedSamll@2x")];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        _tempHeight += TodayImageHeight+10;
        [view addSubview:imageView];
    }
    
    NSString * string = [_items objectAtIndex:0];
    if(string.length<=0){
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    CGFloat height = [UITools calUILabelHeihtByString:string font:Font_Size_Blod(20) width:300];
    
    UIView * whatQianView1 = [UITools createBlackRoundsByString:string font:Font_Size_Blod(20)];
    whatQianView1.top = _tempHeight;
    whatQianView1.left = 10;
    _tempHeight += height+50;
    whatQianView1.backgroundColor = [UIColor clearColor];
    [view addSubview:whatQianView1];

    view.height = _tempHeight+50;
    return view;
}
-(void)updateData
{
    UIView * view = [self customView];
    _glassScrollView.foregroundView = view;
    
}
-(void)imageClicked:(UITapGestureRecognizer*)tap
{


}
-(void)loadData
{
    if (!_items) {
        _items = [[NSMutableArray alloc] initWithArray:self.dict[@"items"]];
    }
    else{
        [_items removeAllObjects];
    }
    
    if (!_imgs) {
        _imgs = [[NSMutableArray alloc] initWithArray:self.dict[@"imgs"]];
    }
    else{
        [_imgs removeAllObjects];
    }
}
-(void)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    content.url = @"https://itunes.apple.com/us/app/sheng-huo-zhu-shou/id877533761";
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
    // 320x50
    ZhuShouAdView * adView = [[ZhuShouAdView alloc] initWithAdView:_glassScrollView controller:self];
    CGFloat statusHeight  = 20;
    CGFloat navHeight = 44;
    CGFloat top = [UIScreen mainScreen].bounds.size.height - CGRectGetHeight(adView.bounds) - statusHeight - navHeight;
    adView.frame = CGRectMake(0,top, CGRectGetWidth(adView.bounds), CGRectGetHeight(adView.bounds));
    adView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    [_glassScrollView addSubview:adView];    
}
@end

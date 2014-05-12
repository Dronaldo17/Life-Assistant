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
        [self.view addSubview:_glassScrollView];
    }
    return self;
}


- (void)viewDidLoad
{
    self.title = @"观音灵签";
    self.leftButtonShow = NO;
    [super viewDidLoad];
    
    //white status bar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //preventing weird inset
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
        
    LKDBHelper *  help =  [[LKDBHelper alloc] initWithDBName:@"lingqian"];
    [help createTableWithModelClass:[LQModel class]tableName:@"lingqianSimple"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    int radomNumber = arc4random() % 100 + 1;
    dict[@"id"] = [NSString stringWithFormat:@"%d",radomNumber];
    NSArray * sourceArray = [help search:[LQModel class] where:dict orderBy:nil offset:0 count:MAXFLOAT tableName:@"lingqianSimple"];
    _model = [[LQModel alloc] init];
    _model = [sourceArray objectAtIndex:0];
    NSLogDebug(@"sourceArray is %@",[[sourceArray objectAtIndex:0] jixiong]);
    [self createButton];
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

    view.height = _tempHeight;
    return view;
}
-(void)rightButtonClicked:(id)sender
{

}
-(void)createButton
{
    UIButton * backButton =[UITools createBarButtonWithObject:PNGIMAGE(@"icon_more_share_n@2x") andWithLeft:NO];
    [backButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.rightBarButtonItem = barButton;

}
@end

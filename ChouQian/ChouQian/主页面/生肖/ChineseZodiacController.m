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
   
    view.height = _tempHeight;
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
    
}
-(void)createButton
{
    UIButton * backButton =[UITools createBarButtonWithObject:PNGIMAGE(@"icon_more_share_n@2x") andWithLeft:NO];
    [backButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.rightBarButtonItem = barButton;
    
}


@end

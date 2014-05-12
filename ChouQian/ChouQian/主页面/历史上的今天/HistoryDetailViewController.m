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
    
    LazyFadeInView * fadeView  = [[LazyFadeInView alloc] initWithFrame:CGRectMake(10, _tempHeight, 300, height)];
    fadeView.text = string;
    _tempHeight += fadeView.height;
    [view addSubview:fadeView];

    view.height = _tempHeight+30;
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
    
}
-(void)createButton
{
    UIButton * backButton =[UITools createBarButtonWithObject:PNGIMAGE(@"icon_more_share_n@2x") andWithLeft:NO];
    [backButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.rightBarButtonItem = barButton;
    
}

@end

//
//  BaseViewController.m
//  XFTIOSClinet
//
//  Created by doujingxuan on 13-11-11.
//  Copyright (c) 2013年 doujingxuan. All rights reserved.
//

#import "BaseViewController.h"
#import "NavTitleView.h"
#import "UINavigationItem+iOS7Spacing.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)performBack:(id)sender
{
    if (self.navigationController.viewControllers.count < 2) {
        [self dismissViewControllerAnimated:YES completion:^(void){}];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NavTitleView * titleView = [[NavTitleView alloc] initWithNavTitle:self.title];
    self.navigationItem.titleView  = titleView;

    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    int osValue = OSVersion();
    if (osValue < 7) {
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-navHeight);
    }
    else{
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        
    }
    self.view.backgroundColor = [UIColor clearColor];

    if (OSVersion() >= 7.0) {
        self.navigationController.navigationBar.translucent = NO;
       self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        self.navigationController.navigationBar.barTintColor = NavBackGroundColor;
    }else {
        UIImage *navBarBackgroundImage = PNGIMAGE(@"Navation@2x");
        navBarBackgroundImage = [navBarBackgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0.5, 0, 0.5) resizingMode:UIImageResizingModeTile];
        [self.navigationController.navigationBar setBackgroundImage:navBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    self.view.backgroundColor = [UIColor clearColor];
    
    if (YES == self.leftButtonShow) {
        UIButton * backButton =[UITools createBarButtonWithObject:PNGIMAGE(@"nav_icon_back@2x") andWithLeft:YES];
        [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.backBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = barButton;
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = NavBackGroundColor;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (UIButton *)createBarButtonWithObject:(id)obj andWithLeft:(BOOL)bIsLeftFlag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0, 0.0, bIsLeftFlag ? 50 : 52, 30.0);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0.0, bIsLeftFlag ? 8.0 : 0.0, 0.0, 0.0);
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *title = (NSString *)obj;
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = Font_Size_Blod(38);
    }else if ([obj isKindOfClass:[UIImage class]]) {
        UIImage *image = (UIImage *)obj;
        CGSize size = image.size;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((52 - size.width) / 2, (30 - size.height) / 2, size.width, size.height)];
        imageView.image = image;
        [btn addSubview:imageView];
    }
    
    UIImage *btn_img = [UIImage imageNamed:bIsLeftFlag ? @"top_left_blue" : @"top_right_blue"];
    btn_img =  [btn_img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15.0, 0.0, 12.0)];
    [btn setBackgroundImage:btn_img forState:UIControlStateNormal];
    UIImage *height_img = [UIImage imageNamed:bIsLeftFlag ? @"top_left_blue_h" : @"top_right_blue_h"];
    height_img = [height_img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 12)];
    [btn setBackgroundImage:height_img forState:UIControlStateHighlighted];
    
    return btn;
}
-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
}
-(void)rightButtonClicked:(id)sender
{
    
}
-(void)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveAd:(YouMiView *)adView {
    NSLogDebug(@"获得广告");
}

- (void)didFailToReceiveAd:(YouMiView *)adView  error:(NSError *)error {
    NSLogDebug(@"获取广告失败");
}

- (void)willPresentScreen:(YouMiView *)adView {
    NSLogDebug(@"将要显示全屏广告");
    
}

- (void)didPresentScreen:(YouMiView *)adView {
    NSLogDebug(@"已显示全屏广告");
}

- (void)willDismissScreen:(YouMiView *)adView {
    NSLogDebug(@"将要退出全屏广告");
    
}

- (void)didDismissScreen:(YouMiView *)adView {
    NSLogDebug(@"取消全屏广告");
}
@end

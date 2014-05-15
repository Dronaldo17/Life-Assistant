//
//  AboutViewController.m
//  ChouQian
//
//  Created by doujingxuan on 14-5-15.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "AboutViewController.h"
#import "LazyFadeInView.h"

@interface AboutViewController ()
{

}
@end

@implementation AboutViewController

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
    self.title = @"关于";
    self.leftButtonShow = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat _tempHeight = 0;
    
    NSString *str = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/About.plist"];
    NSMutableArray * array = [NSMutableArray arrayWithContentsOfFile:str];
    NSMutableDictionary * dict = [array objectAtIndex:0];
    NSString * about = dict[@"about"];

    CGFloat height = [UITools calUILabelHeihtByString:about font:Font_Size_Blod(20) width:300];
    
    LazyFadeInView * fadeView  = [[LazyFadeInView alloc] initWithFrame:CGRectMake(10, _tempHeight, 300, height)];
    fadeView.text = about;
    fadeView.top += 100;
    _tempHeight += fadeView.height;
    [self.view addSubview:fadeView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

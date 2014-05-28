//
//  ChineseZodiacSelectVC.m
//  ChouQian
//
//  Created by doujingxuan on 14-4-7.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "ChineseZodiacSelectVC.h"
#import "UIButton+Bootstrap.h"
#import "LeveyPopListView.h"
#import "ChineseZodiacController.h"

#define Male_Select_Tag 1000

#define Female_Select_Tag 1001

@interface ChineseZodiacSelectVC ()<LeveyPopListViewDelegate>
{
    UIButton * _maleButton;
    UIButton * _femaleButton;
    UIButton * _doneButton;
    LeveyPopListView * _popListView;
    NSArray * _array;
    ChineseZodiacController * _zodiacController;
    UIView * _selectView;
    
}
@end

@implementation ChineseZodiacSelectVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _array = [[NSArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = @"生肖选择";
    self.leftButtonShow  = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"MenuBackground"];
    [self.view addSubview:imageView];
    
    [self addButtons];
    //white status bar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //preventing weird inset
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    
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
#pragma mark 添加按钮
-(void)addButtons
{
    _selectView = [[UIView alloc] initWithFrame:self.view.bounds];
    _maleButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 20, 100, 40)];
    _maleButton.tag = Male_Select_Tag;
    [_maleButton setTitle:@"男" forState:UIControlStateNormal];
    [_maleButton primaryStyle];
    [_maleButton addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_selectView addSubview:_maleButton];

    _femaleButton = [[UIButton alloc] initWithFrame:CGRectMake(180, 20, 100, 40)];
    _femaleButton.tag = Female_Select_Tag;
    [_femaleButton addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_femaleButton setTitle:@"女" forState:UIControlStateNormal];
    [_femaleButton dangerStyle];
    [_selectView addSubview:_femaleButton];
    
    
    _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(120, _femaleButton.bottom + 20, 100, 40)];
    [_doneButton setTitle:@"确定" forState:UIControlStateNormal];
    [_doneButton successStyle];
    [_doneButton addTarget:self action:@selector(doneClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_selectView addSubview:_doneButton];

    [self.view addSubview:_selectView];
    [self.view bringSubviewToFront:_selectView];

}
-(void)doneClicked:(id)sender
{
    if (self.shengxiao1.length <=0 || self.shengxiao2.length <=0) {
        [UITools alertShow:@"请选择两个生肖"];
        return;
    }

     ChineseZodiacController * zodiacController = [[ChineseZodiacController alloc] init];
    
    zodiacController.shengxiao1 = self.shengxiao1;
    zodiacController.shengxiao2 = self.shengxiao2;
    [self.navigationController pushViewController:zodiacController animated:YES];
}
-(void)buttonSelect:(id)sender
{
    UIButton * button = (UIButton*)sender;
    
    if (!_popListView) {
        NSString *str = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/Zodiac.plist"];
        NSArray * array = [NSArray arrayWithContentsOfFile:str];
        _array = array;
        _popListView = [[LeveyPopListView alloc] initWithTitle:@"请选择生肖" options:_array];
        _popListView.delegate = self;
    }
    
    _popListView.tag = button.tag;
    [_popListView showInView:self.view animated:YES];
}
- (void)leveyPopListView:(LeveyPopListView *)popListView didSelectedIndex:(NSInteger)anIndex
{
      NSString * title = [[_array objectAtIndex:anIndex] objectForKey:@"text"];
  
    if (popListView.tag == Male_Select_Tag) {
          NSString * subTitle = [NSString stringWithFormat:@"男♂%@",title];
        self.shengxiao1 = title;
        [_maleButton setTitle:subTitle forState:UIControlStateNormal];
    }
    
    if (popListView.tag == Female_Select_Tag) {
          NSString * subTitle = [NSString stringWithFormat:@"女♀%@",title];
        self.shengxiao2 = title;
        [_femaleButton setTitle:subTitle forState:UIControlStateNormal];
    }
}
- (void)leveyPopListViewDidCancel;
{

}
-(void)backButtonClicked:(id)sender
{
    [self.sideMenuViewController presentMenuViewController]
    ;
}

@end

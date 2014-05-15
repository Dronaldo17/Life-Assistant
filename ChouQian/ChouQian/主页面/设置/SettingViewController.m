//
//  SettingViewController.m
//  ChouQian
//
//  Created by doujingxuan on 14-5-15.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}
@property (nonatomic, strong) NSArray *arr;
@end

@implementation SettingViewController

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
    self.title = @"设置";
    [super viewDidLoad];
    
    NSString *str = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/SettingList.plist"];
    self.arr = [NSArray arrayWithContentsOfFile:str];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kMiddleContentViewHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.opaque = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.backgroundView = nil;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;

    [self.view addSubview:_tableView];
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
#pragma mark - UITableViewDelegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSDictionary*)[_arr objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * customCellID = @"customCellID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:customCellID];
        if (nil == cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCellID];
        }
        cell.textLabel.text = [[[self.arr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"text"];
       NSString * iconString = [[[self.arr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"icon"];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
       cell.imageView.image = [UIImage imageNamed:iconString];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = Menu_Title_Font;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = Font_Size_System(20);
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        UIView * view = [[UIView alloc] init];
        cell.backgroundView = view;
        return cell;
}
@end

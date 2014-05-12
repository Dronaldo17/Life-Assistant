//
//  MenuViewController.m
//  ChouQian
//
//  Created by doujingxuan on 14-3-11.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "MenuViewController.h"
#import "LQViewController.h"
#import "RESideMenu.h"
#import "ChineseZodiacController.h"
#import "ChineseZodiacSelectVC.h"
#import "ConstellationSelectVC.h"
#import "TodayHistoryController.h"

@interface MenuViewController ()
{
    UINavigationController * _lingqianNav;
    UINavigationController * _zodiacNav;
    UINavigationController * _constellationNav;
    UINavigationController * _todayNav;
}
@property (strong, readwrite, nonatomic) UITableView *tableView;
@end

@implementation MenuViewController

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
    [super viewDidLoad];
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 5) / 2.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        
        tableView.backgroundView = nil;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
    
    if (!_lingqianNav) {
        _lingqianNav = [[UINavigationController alloc] initWithRootViewController:[[LQViewController alloc] initWithImage:[UIImage imageNamed:@"MenuBackground"]]];
    }
    
    self.sideMenuViewController.contentViewController = _lingqianNav;
    [self.sideMenuViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            if (!_lingqianNav) {
                _lingqianNav = [[UINavigationController alloc] initWithRootViewController:[[LQViewController alloc] initWithImage:[UIImage imageNamed:@"MenuBackground"]]];
            }
            
            self.sideMenuViewController.contentViewController = _lingqianNav;
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 1:{
            if (!_zodiacNav) {
                _zodiacNav =[[UINavigationController alloc] initWithRootViewController:[[ChineseZodiacSelectVC alloc] init]];
            }
             self.sideMenuViewController.contentViewController = _zodiacNav;
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 2:{
            if (!_constellationNav) {
                _constellationNav =[[UINavigationController alloc] initWithRootViewController:[[ConstellationSelectVC alloc] init]];
            }
            self.sideMenuViewController.contentViewController = _constellationNav;
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 3:{
            if (!_todayNav) {
                _todayNav = [[UINavigationController alloc] initWithRootViewController:[[TodayHistoryController alloc] init]];
            }
            self.sideMenuViewController.contentViewController = _todayNav;
            [self.sideMenuViewController hideMenuViewController];
        
        }
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = Menu_Title_Font;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    NSArray *titles = @[@"每日一签", @"生肖", @"星座", @"历史上的今天", @"生日"];
    NSArray *images = @[@"IconHome", @"IconCalendar", @"IconProfile", @"IconSettings", @"IconEmpty"];
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end

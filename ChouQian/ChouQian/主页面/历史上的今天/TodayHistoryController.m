//
//  TodayHistoryController.m
//  ChouQian
//
//  Created by doujingxuan on 14-5-3.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "TodayHistoryController.h"
#import "TodayDataParse.h"
#import "BannerScrollerView.h"
#import "AFHTTPRequestOperation.h"
#import "TadayCell.h"
#import "TodayModel.h"
#import "HistoryDetailViewController.h"
#import "TodayDataModel.h"
#import "TodayDetailModel.h"
#import "TodayDataParse.h"


#define TodayTableName @"TodayTableName"

@interface TodayHistoryController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _items;
    NSMutableArray * _foucs;
    ADLivelyTableView * _tableView;
    TodayModel * _model;
    BannerScrollerView * _bannerScrollerView;
}
@end

typedef void(^GetTodayDataSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);

typedef void(^GetTodayDataFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@implementation TodayHistoryController

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
    self.title = @"历史上的今天";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[ADLivelyTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.height -= 64;
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.initialCellTransformBlock = ADLivelyTransformFade;
    
    _model = [[TodayModel alloc] init];

    [self.view addSubview:_tableView];
        
    [self loadData];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_bannerScrollerView startTimer];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_bannerScrollerView stopTimer];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadData
{
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter1 setDateFormat:@"YYYYMMdd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr1 = [dateFormatter1 stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13
    NSLogWarn(@"%@",currentDateStr1);
    
    NSString * todayString = [TodayDataManger  backDayStringByDate:currentDateStr1];
    
    if (todayString.length>0) {
        NSMutableDictionary * dict = [todayString objectFromJSONString];
        _items = [[NSMutableArray alloc] initWithArray:dict[@"items"]];
        _foucs = [[NSMutableArray alloc] initWithArray:dict[@"foucs"]];
        [self updateDataSource];
    }
    else{
        [self getTodayDataFromNetwork];
    }
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
#pragma mark UITableView Delegate And DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"TodayHistory";
    TadayCell * cell = (TadayCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[TadayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    id value = [_items objectAtIndex:indexPath.row];

    if ([value isKindOfClass:[NSDictionary class]]) {
        _model = [TodayDataParse dictToTodayModel:value];
    }
    else{
        _model = value;
    }
    [cell updateByData:_model];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id object = [_items objectAtIndex:indexPath.row];
    TodayModel * model = [[TodayModel alloc] init];
    if ([object isKindOfClass:[TodayModel class]]) {
        model = object;
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        model = [TodayDataParse dictToTodayModel:object];
    }
    
    if (model.href.length <= 0) {
        return;
    }
    
    
    NSString * detailString = [TodayDataManger backDetailStringByHref:model.href];
    if (detailString.length > 0) {
        NSMutableDictionary * dict = [detailString objectFromJSONString];
        [self pushDetailPage:dict viewController:self];
    }
    else{
        [self getTodayDetailDataFromNetWork:model.href model:model];
    }
}
-(void)updateDataSource
{
    if (!_bannerScrollerView) {
        _bannerScrollerView = [[BannerScrollerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 170) dataArray:_foucs];
    }
    _tableView.tableHeaderView = _bannerScrollerView;
    [_tableView reloadData];
}
-(void)getTodayDataFromNetwork
{
    [UITools showHudTitle:@"请求中"];
    GetTodayDataSuccessBlock  successBlock = ^(AFHTTPRequestOperation *operation, id responseObject){
        [UITools hideLoadingView];
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dict = responseObject;
        }
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSData * data = (NSData*)responseObject;
            dict = [TodayDataParse todayDataParse:data];
        }
        
        _items = [[NSMutableArray alloc] initWithArray:dict[@"items"]];
        _foucs = [[NSMutableArray alloc] initWithArray:dict[@"foucs"]];
        [self updateDataSource];
        
    };
    GetTodayDataSuccessBlock failureBlock = ^(AFHTTPRequestOperation *operation, NSError *error){
        NSLogDebug(@"获取数据错误");
        [UITools hideLoadingView];
    };
    [TodayDataParse todayDataParseByDateSuccess:successBlock failure:failureBlock];
}
-(void)getTodayDetailDataFromNetWork:(NSString*)href model:(TodayModel*)model
{
    GetTodayDataSuccessBlock  successBlock = ^(AFHTTPRequestOperation *operation, id responseObject){
        [UITools hideLoadingView];
        
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSData * data = (NSData*)responseObject;
            dict = [[NSMutableDictionary alloc] initWithDictionary:[TodayDataParse parseTodayDetailData:data]];
        }
        if ([responseObject  isKindOfClass:[NSMutableDictionary class]])
        {
            dict = responseObject;
        }
        
        NSString * jsonString1 = [dict JSONString];
        
        AVObject *testObject = [AVObject objectWithClassName:TodayDetailName];
        [testObject setObject:jsonString1 forKey:TodayDetailInfo];
        [testObject setObject:model.href forKey:TodayHref];
        [testObject save];
        
        BOOL success = [TodayDataManger saveDayStringByHref:model.href string:jsonString1];
        NSLogWarn(@"success is %d",success);
      
        [self pushDetailPage:dict viewController:self];
    };
    GetTodayDataSuccessBlock failureBlock = ^(AFHTTPRequestOperation *operation, NSError *error){
        NSLogDebug(@"获取数据错误");
        [UITools hideLoadingView];
    };
    [TodayDataParse parseTodayDetailDataURL:[NSURL URLWithString:model.href] Success:successBlock failure:failureBlock];
}
-(void)pushDetailPage:(NSMutableDictionary*)dict viewController:(UIViewController*)controller
{
    HistoryDetailViewController * dvc = [[HistoryDetailViewController alloc] init];
    dvc.dict = dict;
    [controller.navigationController pushViewController:dvc animated:YES];
}
@end

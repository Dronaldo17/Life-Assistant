//
//  BannerScrollerView.m
//  ChouQian
//
//  Created by doujingxuan on 14-5-4.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "BannerScrollerView.h"
#import "BannerView.h"
#import "TodayFoucsModel.h"
#import "NSTimer+Addition.h"
#import "TodayDataParse.h"

@implementation BannerScrollerView
@synthesize cycCleSrollView = _cycCleSrollView;
-(id)initWithFrame:(CGRect)frame dataArray:(NSMutableArray*)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableArray * views = [[NSMutableArray alloc] initWithCapacity:5];
        for (int i = 0; i<dataArray.count; i++) {
            id value = [dataArray objectAtIndex:i];
            TodayFoucsModel * model = [[TodayFoucsModel alloc] init];
            if ([value isKindOfClass:[NSDictionary class]]) {
                model = [TodayDataParse dictToTodayFoucsModel:value];
            }
            else{
                model = [dataArray objectAtIndex:i];
            }
            NSString * title = model.content;
             NSString * bgImageURL = model.iconURLString;
            BannerView * banner = [[BannerView alloc] initWithTitle:title bgImageURL:bgImageURL frame:frame tag:i];
            [views addObject:banner];
        }
        
        _cycCleSrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 170) animationDuration:2.5];
        
       _cycCleSrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            return views[pageIndex];
        };
       _cycCleSrollView.totalPagesCount = ^NSInteger(void){
            return dataArray.count;
        };
        _cycCleSrollView.TapActionBlock = ^(NSInteger pageIndex){
            NSLogDebug(@"点击了第%d个",pageIndex);
        };
        [self addSubview:_cycCleSrollView];
    }
    return self;
}
-(void)stopTimer
{
    [_cycCleSrollView.animationTimer pauseTimer];
}
-(void)startTimer
{
    [_cycCleSrollView.animationTimer resumeTimer];
}

@end

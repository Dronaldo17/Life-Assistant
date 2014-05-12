//
//  BannerScrollerView.h
//  ChouQian
//
//  Created by doujingxuan on 14-5-4.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"

@interface BannerScrollerView : UIView
{
    CycleScrollView * _cycCleSrollView;
}
@property (nonatomic,strong) CycleScrollView * cycCleSrollView;
-(id)initWithFrame:(CGRect)frame dataArray:(NSMutableArray*)dataArray;
-(void)stopTimer;
-(void)startTimer;


@end

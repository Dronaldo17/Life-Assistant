//
//  TadayCell.h
//  ChouQian
//
//  Created by doujingxuan on 14-5-4.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TodayModel;
@interface TadayCell : UITableViewCell
{
    UIImageView * _icon;
    UILabel * _timeLabel;
    UILabel * _contentLabel;
}
-(void)updateByData:(TodayModel*)model;
@end

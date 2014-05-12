//
//  TadayCell.m
//  ChouQian
//
//  Created by doujingxuan on 14-5-4.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "TadayCell.h"
#import "TodayModel.h"
#import "TodayDataParse.h"

@implementation TadayCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 40)];
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 20)];
        _contentLabel =[[UILabel alloc] initWithFrame:CGRectMake(80, 35, 200, 20)];
        _timeLabel.font = Font_Size_Blod(14);
        _contentLabel.font = Font_Size_System(15);
        [self.contentView addSubview:_icon];
        [self.contentView addSubview:_timeLabel];
        [self.contentView addSubview:_contentLabel];
    }
    return self;
}
-(void)updateByData:(TodayModel*)model
{
    [_icon setImageWithURL:[NSURL URLWithString:model.iconURLString] placeholderImage:PNGIMAGE(@"PhotoDownloadfailedSamll@2x")];
    if (model.href.length > 0) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
         self.accessoryType = UITableViewCellAccessoryNone;
    }

    _timeLabel.text = model.time;
    _contentLabel.text  = model.content;
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

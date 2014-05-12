

//  NavTitleView.m
//  BallFriend
//
//  Created by doujingxuan on 13-9-27.
//  Copyright (c) 2013年 doujingxuan. All rights reserved.
//

#import "NavTitleView.h"

@implementation NavTitleView

- (id)initWithFrame:(CGRect)frame  title:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.title = title;
        UILabel * label = [[UILabel alloc] initWithFrame:self.bounds];
        label.text = title;
        label.font = Font_Size_System(37);
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
    }
    return self;
}
-(id)initWithNavTitle:(NSString*)title
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 150, 40);
        self.title = title;
        UILabel * label = [[UILabel alloc] initWithFrame:self.bounds];
        label.text = title;
        label.font = Nav_Title_Font;
        label.textColor = RGBCOLOR(255, 255, 255);
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
    }
    return self;
}

-(void)addtitleLabel:(NSString*)title
{
    UILabel * label = [[UILabel alloc] initWithFrame:self.bounds];
    label.text = title;
    label.font = [UIFont boldSystemFontOfSize:22.0];
    label.textColor = RGBCOLOR(255, 255, 255);
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
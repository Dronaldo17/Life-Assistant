//
//  NavTitleView.h
//  XFTIOSClinet
//
//  Created by doujingxuan on 13-11-18.
//  Copyright (c) 2013年 doujingxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NavTitleView : UIView

@property (nonatomic,retain)NSString * title;
-(id)initWithNavTitle:(NSString*)title;
-(id)initWithFrame:(CGRect)frame  title:(NSString*)title;
-(void)addtitleLabel:(NSString*)title;
@end

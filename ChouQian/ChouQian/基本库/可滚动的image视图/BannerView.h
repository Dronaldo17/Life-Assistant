//
//  BannerView.h
//  ChouQian
//
//  Created by doujingxuan on 14-5-4.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerView : UIView
{
    UIImageView * _bgImageView;
    UILabel * _titleLabel;
}
-(id)initWithTitle:(NSString*)title bgImageURL:(NSString*)bgImageURL frame:(CGRect)frame tag:(NSUInteger)tag;
@end

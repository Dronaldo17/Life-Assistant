//
//  BannerView.m
//  ChouQian
//
//  Created by doujingxuan on 14-5-4.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "BannerView.h"

@implementation BannerView
-(id)initWithTitle:(NSString*)title bgImageURL:(NSString*)bgImageURL frame:(CGRect)frame tag:(NSUInteger)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if ([bgImageURL hasPrefix:@"http://"]) {
            
        }
        else{
            bgImageURL = [NSString stringWithFormat:@"http://www.todayonhistory.com/%@",bgImageURL];
        }
        _bgImageView = [[UIImageView alloc] initWithFrame:frame];
        [_bgImageView setImageWithURL:[NSURL URLWithString:bgImageURL] placeholderImage:PNGIMAGE(@"todayBg@2x")];
        _bgImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheBgImage:)];
        _bgImageView.userInteractionEnabled = YES;
        _bgImageView.tag = tag;
        [_bgImageView addGestureRecognizer:tap];
        
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 2 * 10, 20)];
        _titleLabel.text = title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        [_titleLabel sizeToFit];
       
        _titleLabel.top = _bgImageView.bottom - _titleLabel.height;
        
        [self addSubview:_bgImageView];
        [self addSubview:_titleLabel];
    }
    return self;




}
-(void)tapTheBgImage:(UITapGestureRecognizer*)tap
{
    NSLogDebug(@"UITapGestureRecognizer Bg Image");

}
@end

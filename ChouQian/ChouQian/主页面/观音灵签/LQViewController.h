//
//  LQViewController.h
//  ChouQian
//
//  Created by doujingxuan on 14-3-9.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "BaseViewController.h"
#import "BTGlassScrollView.h"

@interface LQViewController : BaseViewController
@property (nonatomic, assign) int index;
@property (nonatomic, strong) BTGlassScrollView *glassScrollView;
- (id)initWithImage:(UIImage *)image;
@end

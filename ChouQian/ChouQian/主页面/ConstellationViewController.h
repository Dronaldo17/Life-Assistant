//
//  ConstellationViewController.h
//  ChouQian
//
//  Created by doujingxuan on 14-4-24.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "BaseViewController.h"

@interface ConstellationViewController : BaseViewController
@property (nonatomic, assign) int index;
@property (nonatomic, strong) BTGlassScrollView *glassScrollView;
@property (nonatomic,copy)NSString * f_AstroName1;
@property (nonatomic,copy)NSString * f_AstroName2;
- (id)initWithImage:(UIImage *)image;

@end

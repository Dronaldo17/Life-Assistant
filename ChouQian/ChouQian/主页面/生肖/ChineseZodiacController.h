//
//  ChineseZodiacController.h
//  ChouQian
//
//  Created by doujingxuan on 14-3-21.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "BaseViewController.h"

@interface ChineseZodiacController : BaseViewController
@property (nonatomic, assign) int index;
@property (nonatomic, strong) BTGlassScrollView *glassScrollView;
@property (nonatomic, copy)NSString * shengxiao1;
@property (nonatomic, copy)NSString * shengxiao2;

- (id)initWithImage:(UIImage *)image;
@end

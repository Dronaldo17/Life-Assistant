//
//  HistoryDetailViewController.h
//  ChouQian
//
//  Created by doujingxuan on 14-5-4.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "BaseViewController.h"

@interface HistoryDetailViewController : BaseViewController
{
    UIImageView * _imageView;
    
}
@property (nonatomic, strong) BTGlassScrollView *glassScrollView;
@property (nonatomic,copy)NSString * urlString;
@property (nonatomic,strong)NSMutableDictionary * dict;
@end

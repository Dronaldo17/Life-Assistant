//
//  BaseViewController.h
//  XFTIOSClinet
//
//  Created by doujingxuan on 13-11-11.
//  Copyright (c) 2013年 doujingxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+UU.h"

@interface BaseViewController : UIViewController
{
    UILabel *_titleView;
}
@property (nonatomic,assign)BOOL leftButtonShow;

-(void)backButtonClicked:(id)sender;
-(void)rightButtonClicked:(id)sender;
@end
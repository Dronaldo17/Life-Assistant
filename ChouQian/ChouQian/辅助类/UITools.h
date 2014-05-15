//
//  UITools.h
//  ChouQian
//
//  Created by doujingxuan on 14-3-12.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITools : NSObject

/*作者:窦静轩    描述:创建黑色圆角的view*/
+(UIView*)createBlackRoundsByString:(NSString*)string font:(UIFont*)font;

/*作者:窦静轩    描述:计算UILabel高度*/
+(CGFloat)calUILabelHeihtByString:(NSString*)string font:(UIFont*)font width:(CGFloat)width;

/*作者:窦静轩    描述:弹出警示框*/
+(void)alertShow:(NSString*)alertInfo;


/*作者:窦静轩    描述:显示loading 图*/
+(void)showHudTitle:(NSString*)title;

/*作者:窦静轩    描述:隐藏loading图*/
+(void)hideLoadingView;


/*作者:窦静轩    描述:添加左边返回按钮*/
+ (UIButton *)createBarButtonWithObject:(id)obj andWithLeft:(BOOL)bIsLeftFlag;

/**Author:Ronaldo Description:去评分*/
+(void)openAppStroreWihtViewController:(UIViewController*)controller;
@end

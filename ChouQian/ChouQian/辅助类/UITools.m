//
//  UITools.m
//  ChouQian
//
//  Created by doujingxuan on 14-3-12.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "UITools.h"
#import "CQLabel.h"
#import "SettingViewController.h"

@implementation UITools
/*作者:窦静轩    描述:创建黑色圆角的view*/
+(UIView*)createBlackRoundsByString:(NSString*)string font:(UIFont*)font
{
    UIView *box1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
    box1.layer.cornerRadius = 3;
    box1.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
    
    CQLabel * label1 = [[CQLabel alloc] initWithFrame:CGRectMake(10, 0, 280, 80)];
    [label1 setTextColor:[UIColor whiteColor]];
    [label1 setFont:font];
    [label1 setShadowColor:[UIColor blackColor]];
    [label1 setShadowOffset:CGSizeMake(1, 1)];
    [label1 setTopText:string numberOfLines:0];
    label1.top += 3;
    [label1 setBackgroundColor:[UIColor clearColor]];
    [box1 addSubview:label1];
    
    CGFloat height = [UITools calUILabelHeihtByString:string font:font width:box1.width];
    NSLogDebug(@"height is %f",height);
    box1.height = height + 5;
    
    return box1;
}

/*作者:窦静轩    描述:计算UILabel高度*/
+(CGFloat)calUILabelHeihtByString:(NSString*)string font:(UIFont*)font width:(CGFloat)width
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size.height;
}

+(void)alertShow:(NSString*)alertInfo
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView * av =[[UIAlertView alloc] initWithTitle:nil message:alertInfo delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        
    });
}
+(void)showHudTitle:(NSString*)title
{
    [SVProgressHUD showWithStatus:title maskType:SVProgressHUDMaskTypeBlack];
}
+(void)hideLoadingView
{
    [SVProgressHUD dismiss];
}
+ (UIButton *)createBarButtonWithObject:(id)obj andWithLeft:(BOOL)bIsLeftFlag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0, 0.0, bIsLeftFlag ? 50 : 52, 30.0);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0.0, bIsLeftFlag ? 8.0 : 0.0, 0.0, 0.0);
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *title = (NSString *)obj;
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = Font_Size_Blod(20);
    }else if ([obj isKindOfClass:[UIImage class]]) {
        UIImage *image = (UIImage *)obj;
        CGSize size = image.size;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((52 - size.width) / 2, (30 - size.height) / 2, size.width, size.height)];
        imageView.image = image;
        [btn addSubview:imageView];
    }
    
    UIImage *btn_img = [UIImage imageNamed:bIsLeftFlag ? @"" : @""];
    btn_img =  [btn_img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15.0, 0.0, 12.0)];
    [btn setBackgroundImage:btn_img forState:UIControlStateNormal];
    UIImage *height_img = [UIImage imageNamed:bIsLeftFlag ? @"" : @""];
    height_img = [height_img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 12)];
    [btn setBackgroundImage:height_img forState:UIControlStateHighlighted];
    
    return btn;
}
+(void)openAppStroreWihtViewController:(UIViewController*)controller
{
    int version = OSVersion();
    if (version > 6) {
        [UITools openAppStroreInApp:controller];
    }
    else{
        [UITools openAppStroreOutApp];
    }
}
+(void)openAppStroreInApp:(UIViewController*)controller
{
    // Initialize Product View Controller
    SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
    // Configure View Controller
    [storeProductViewController setDelegate:(SettingViewController*)controller];
    [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @"509986973"}
                                          completionBlock:^(BOOL result, NSError *error) {
                                              if (error) {
                                                  NSLogWarn(@"Error %@ with User Info %@.", error, [error userInfo]);
                                              } else {
                                                  // Present Store Product View Controller
                                                  [controller presentViewController:storeProductViewController animated:YES completion:nil];
                                              }
                                          }];
    
}
+(void)openAppStroreOutApp
{
    NSString *str = [NSString stringWithFormat:
                     @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",
                     App_ID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}


@end

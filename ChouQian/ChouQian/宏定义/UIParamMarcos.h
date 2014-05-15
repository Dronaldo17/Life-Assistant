//
//  UIParamMarcos.h
//  ChouQian
//
//  Created by doujingxuan on 14-3-7.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//


//6.0一下兼容6.0枚举类型，避免版本导致的警告
#define UILineBreakMode                 NSLineBreakMode
#define UILineBreakModeWordWrap			NSLineBreakByWordWrapping
#define UILineBreakModeCharacterWrap	NSLineBreakByCharWrapping
#define UILineBreakModeClip				NSLineBreakByClipping
#define UILineBreakModeHeadTruncation	NSLineBreakByTruncatingHead
#define UILineBreakModeTailTruncation	NSLineBreakByTruncatingTail
#define UILineBreakModeMiddleTruncation	NSLineBreakByTruncatingMiddle

#define UITextAlignment                 NSTextAlignment
#define UITextAlignmentLeft				NSTextAlignmentLeft
#define UITextAlignmentCenter			NSTextAlignmentCenter
#define UITextAlignmentRight			NSTextAlignmentRight


// PNG JPG 图片路径
#define PNGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME, EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

// 加载图片
#define PNGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME, EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]

#define IMAGENAMED(NAME)        [UIImage imageNamed:NAME]

// 颜色(RGB)
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// 当前语言
#define CURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])

// 是否Retina屏
#define isRetina                ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 960), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

// 是否iPhone5
#define isiPhone5               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// UIView - viewWithTag
#define VIEWWITHTAG(_OBJECT, _TAG)\
                                \
                                [_OBJECT viewWithTag : _TAG]

// App Name
#define AppDisplayName          [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]

/** 一天的秒数 */
#define SecondsOfDay            (24.f * 60.f * 60.f)
/** 秒数 */
#define Seconds(Days)           (24.f * 60.f * 60.f * (Days))


#define Font_Size_Blod(_f) [UIFont fontWithName:@"STHeitiSC-Medium" size:(_f)]

#define Font_Size_System(_f) [UIFont fontWithName:@"STHeitiSC-Light" size:(_f)]



#define JiXiong_Font    [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60]

#define Menu_Title_Font    [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:26]


#define Nav_Title_Font    [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:22]

#define QianShu_Font()    [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:24]

#define HelveticFont_(f)  [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:f]


#define NavBackGroundColor RGBACOLOR(12, 109, 190,0.8)


#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kStatusBarHeight 20.0f
#define kNavigationBarHeight 44.0f
#define kNavigationBarLandscapeHeight 33.0f
#define kTabBarHeight 49.0f
#define kContentViewHeight (kScreenHeight - kStatusBarHeight - kNavigationBarHeight)
#define kMiddleContentViewHeight (kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight)
#define KChatContentTableHeight (kScreenHeight - kStatusBarHeight - kNavigationBarHeight - 44)
#define kLongButtonFrame(__offsetY) CGRectMake(9.0, __offsetY, kScreenWidth - 18.0, 40.0)

/*作者:窦静轩    描述:主线程刷新*/
#define XFT_MAIN(block) dispatch_async(dispatch_get_main_queue(), block)


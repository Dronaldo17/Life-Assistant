//
//  CQLabel.m
//  ChouQian
//
//  Created by doujingxuan on 14-3-12.
//  Copyright (c) 2014年 doujingxuan. All rights reserved.
//

#import "CQLabel.h"

@implementation CQLabel
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsLayout];
}
-(void)setTopText:(NSString*)text numberOfLines:(NSUInteger)numberOfLines
{
    
    self.numberOfLines = numberOfLines;
    text = [ParseTools replaceAStringbyBStringWithEnter:text];
    NSDictionary *attribute = @{NSFontAttributeName:self.font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(self.width,0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    NSLogDebug(@"size.height is %f",size.height);
    
    CGAffineTransform transform = self.transform;
    self.transform = CGAffineTransformIdentity;
    CGRect frame = self.frame;
    frame.size.height = size.height;
    self.frame = frame;
    self.transform = transform;
    [super setText:text];
}


@end

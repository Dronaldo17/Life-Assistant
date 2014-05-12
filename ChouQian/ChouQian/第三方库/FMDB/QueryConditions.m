//
//  QueryConditions.m
//  FaceChatDemo
//
//  Created by doujingxuan on 13-10-28.
//
//

#import "QueryConditions.h"

@implementation QueryConditions
@synthesize where,offset,orderBy,count;
- (void)dealloc
{
    self.where = nil;
    self.orderBy = nil;
}
@end

//
//  QueryConditions.h
//  FaceChatDemo
//
//  Created by doujingxuan on 13-10-28.
//
//

#import <Foundation/Foundation.h>

@interface QueryConditions : NSObject
@property (nonatomic,copy)NSString * where;
@property (nonatomic,copy)NSString * orderBy;
@property (nonatomic,assign)NSUInteger count;
@property (nonatomic,assign)NSUInteger offset;
@end

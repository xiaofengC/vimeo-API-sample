//
//  VideoData.m
//  VimeoTest
//
//  Created by Xiaofeng Chen on 12/7/14.
//  Copyright (c) 2014 Xiaofeng Chen. All rights reserved.
//

#import "VideoData.h"

@implementation VideoData

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.userName=@"";
        self.thumbNail = [[ThumbNail alloc] init];
        [self.thumbNail setWidth:0];
        [self.thumbNail setHeight:0];
        [self.thumbNail setThumbNailUrl:@""];
    }
    
    return self;
}

@end

//
//  VideoData.h
//  VimeoTest
//
//  Created by Xiaofeng Chen on 12/7/14.
//  Copyright (c) 2014 Xiaofeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThumbNail.h"

@interface VideoData : NSObject

@property (nonatomic,strong) NSString * userName;
@property (nonatomic,strong) ThumbNail * thumbNail;
@end

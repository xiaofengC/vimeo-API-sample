//
//  ThumbNail.h
//  VimeoTest
//
//  Created by Xiaofeng Chen on 12/9/14.
//  Copyright (c) 2014 Xiaofeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ThumbNail : NSObject
@property (nonatomic,strong) NSString * thumbNailUrl;
@property (nonatomic,readwrite) CGFloat width;
@property (nonatomic,readwrite) CGFloat height;

@end

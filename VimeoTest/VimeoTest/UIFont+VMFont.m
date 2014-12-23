//
//  UIFont+VMFont.m
//  VimeoTest
//
//  Created by Xiaofeng Chen on 12/9/14.
//  Copyright (c) 2014 Xiaofeng Chen. All rights reserved.
//

#import "UIFont+VMFont.h"

@implementation UIFont (VMFont)

+ (UIFont*)VMHelNeueFontWithSize:(NSInteger)inSize
{
    return [UIFont fontWithName:@"Helvetica Neue" size:inSize];
}

+ (UIFont*)VMHelNeueBoldFontWithSize:(NSInteger)inSize{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:inSize];
}

@end

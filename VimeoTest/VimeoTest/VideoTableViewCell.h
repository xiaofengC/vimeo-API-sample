//
//  VideoTableViewCell.h
//  VimeoTest
//
//  Created by Xiaofeng Chen on 12/8/14.
//  Copyright (c) 2014 Xiaofeng Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString * const kVideoTableViewCellIdentifier ;
extern CGFloat const kVideoTableViewCellHeight;
extern CGFloat const kTumbNailImageHeight;
extern CGFloat const kTumbNailImageWidth;

@interface VideoTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView * thumbNailImageView;
@property(nonatomic,strong) UILabel * nameLabel;


-(void)resizeLabel;
@end

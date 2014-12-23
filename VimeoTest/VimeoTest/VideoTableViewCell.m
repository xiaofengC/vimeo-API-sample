//
//  VideoTableViewCell.m
//  VimeoTest
//
//  Created by Xiaofeng Chen on 12/8/14.
//  Copyright (c) 2014 Xiaofeng Chen. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "UIFont+VMFont.h"

@implementation VideoTableViewCell

NSString * const kVideoTableViewCellIdentifier = @"kVideoTableViewCell";
CGFloat const kVideoTableViewCellHeight=75.f;
CGFloat const kTumbNailImageHeight=75.f;
CGFloat const kTumbNailImageWidth=100.f;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGFloat paddingX =20;
        CGFloat paddingY =10;
        
        self.thumbNailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 100, 75)];
        [self.contentView addSubview:self.thumbNailImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.thumbNailImageView.frame.origin.x+self.thumbNailImageView.frame.size.width+paddingX, paddingY, self.contentView.frame.size.width-self.thumbNailImageView.frame.size.width-paddingX, self.thumbNailImageView.frame.size.height-2*paddingY)];
        [self.nameLabel setBackgroundColor:[UIColor clearColor]];
        [self.nameLabel setFont:[UIFont VMHelNeueBoldFontWithSize:15]];
        [self.nameLabel setNumberOfLines:0];
        [self.nameLabel setLineBreakMode:NSLineBreakByWordWrapping] ;
        [self.contentView addSubview:self.nameLabel];
        
        
    }
    return self;
}

-(void)resizeLabel{
    CGFloat paddingX =20;
    CGFloat paddingY =10;
    
    [self.nameLabel setFrame:CGRectMake(self.thumbNailImageView.frame.origin.x+self.thumbNailImageView.frame.size.width+paddingX, paddingY, self.contentView.frame.size.width-self.thumbNailImageView.frame.size.width-paddingX, self.thumbNailImageView.frame.size.height-2*paddingY)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

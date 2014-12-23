//
//  ViewController.h
//  VimeoTest
//
//  Created by Xiaofeng Chen on 12/6/14.
//  Copyright (c) 2014 Xiaofeng Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoFeedsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) UITableView * videoTableView ;

@end


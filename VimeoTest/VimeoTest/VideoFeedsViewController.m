//
//  ViewController.m
//  VimeoTest
//
//  Created by Xiaofeng Chen on 12/6/14.
//  Copyright (c) 2014 Xiaofeng Chen. All rights reserved.
//

#import "VideoFeedsViewController.h"
#import "VMAPIClient.h"
#import "VideoData.h"
#import "VideoTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <DLAVAlertView.h>
#import "UIColor+VMColor.h"
@interface VideoFeedsViewController ()

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, readwrite) NSInteger currentpagenumber ;
@property (nonatomic, readwrite) BOOL isPageRefresing ;

@end

@implementation VideoFeedsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    self.videoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, statusBarHeight, self.view.frame.size.width, self.view.frame.size.height-statusBarHeight)];
    [self.videoTableView setBackgroundColor:[UIColor VMLightGrayColor]];
    [self.videoTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.videoTableView setDataSource:self];
    [self.videoTableView setDelegate:self];
    [self.videoTableView setPagingEnabled:YES];
    [self.view addSubview:self.videoTableView];
    
    // set up paging parameters
    self.isPageRefresing=NO;
    self.currentpagenumber=1;
    
    // pull to refresh
    self.refreshControl = [UIRefreshControl new];
    [self.videoTableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.dataArray = [NSMutableArray array];
    [self getInitialDataList];
}


#pragma mark - Networking

-(void)getInitialDataList{
    [self getDataListWithPaging:1];
    
}

-(void)getDataListWithPaging :(NSInteger)page{
    
    [[VMAPIClient sharedClient] getVideoListWithId:@"staffpicks" Page:page to:self.dataArray success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray * videoArray = responseObject[@"data"];
        for (NSDictionary * data in videoArray) {
            VideoData * video = [[VideoData alloc] init];
            NSArray * pictureArray = data[@"pictures"][@"sizes"];
            NSDictionary * thumbNail =[pictureArray objectAtIndex:0];
            [video.thumbNail setThumbNailUrl:thumbNail[@"link"]];
            [video.thumbNail setWidth:[thumbNail[@"width"] floatValue]];
            [video.thumbNail setHeight:[thumbNail[@"height"] floatValue]];
            [video setUserName:data[@"user"][@"name"]];
            
            [self.dataArray addObject:video];
            
        }
        
        [self.videoTableView reloadData];
        [self didEndRefreshing];
        self.isPageRefresing = NO;
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self handleError:error];
        [self didEndRefreshing];
        self.isPageRefresing = NO;
    }
     ];
}

#pragma mark - UIRefreshControl

-(void)refreshData{
    [self getDataListWithPaging:self.currentpagenumber];
}

- (void)didEndRefreshing
{
    if (self.refreshControl.refreshing) {
        [self.refreshControl endRefreshing];
    }
}

#pragma mark - DLAVAlertView
- (void)handleError:(NSError *)error{
    // display user friendly error
    
    if(![AFNetworkReachabilityManager sharedManager].reachable){
        DLAVAlertView *alertView = [[DLAVAlertView alloc] initWithTitle:@"Oops!" message:@"Please make sure you are connecting to a network." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView showWithCompletion:nil];
        
    }else{
        DLAVAlertView *alertView = [[DLAVAlertView alloc] initWithTitle:@"Oops!" message:@"There are something wrong , Please try again latter." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView showWithCompletion:nil];
        
    }
    NSString * message = error.localizedDescription;
    // send error to the server or use some bug tracking tool.
    NSLog(@"Error = %@",message);
    
}


#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kVideoTableViewCellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kVideoTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[VideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kVideoTableViewCellIdentifier];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    VideoData * tempData = [self.dataArray objectAtIndex:indexPath.row];
    
    
    [cell.thumbNailImageView sd_setImageWithURL:[NSURL URLWithString:tempData.thumbNail.thumbNailUrl]placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [cell.nameLabel setText:tempData.userName];
    
    //resize in case image size change
    if(tempData.thumbNail.width&&tempData.thumbNail.height&&(tempData.thumbNail.width!=kTumbNailImageWidth||tempData.thumbNail.height!=kTumbNailImageHeight)){
        [cell.thumbNailImageView setFrame:CGRectMake(0, 0, tempData.thumbNail.width, tempData.thumbNail.height)];
        [cell resizeLabel];
    }
    
    return cell;
}

#pragma mark - Paging
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint*)targetContentOffset
{
    if(self.videoTableView.contentOffset.y >= (self.videoTableView.contentSize.height - self.videoTableView.bounds.size.height)) {
        
        if(!self.isPageRefresing ){
            self.currentpagenumber = self.currentpagenumber +1;
            [self getDataListWithPaging:self.currentpagenumber];
            self.isPageRefresing = YES;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

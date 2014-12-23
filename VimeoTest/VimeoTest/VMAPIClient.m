//
//  VMAPIClient.m
//  VimeoTest
//
//  Created by Xiaofeng Chen on 12/6/14.
//  Copyright (c) 2014 Xiaofeng Chen. All rights reserved.
//

#import "VMAPIClient.h"

@implementation VMAPIClient

NSString * const kVMACCESSTOKEN = @"bearer 042007dc45ba4d3583a4eaa09e46c3dc";
NSString * const kVMBaseURLString = @"https://api.vimeo.com/";

+ (VMAPIClient *)sharedClient {
    static VMAPIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.HTTPAdditionalHeaders = @{@"Authorization": kVMACCESSTOKEN};
        
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kVMBaseURLString] sessionConfiguration:configuration];

    });
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration*)configuration{
    
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    if (!self) {
        return nil;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
//    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/vnd.vimeo.video+json"];
    


    return self;
}

- (void)getVideoListWithId:(NSString *)videoID Page:(NSInteger)pageNumber to:(NSMutableArray*)toArray success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSString * path = [NSString stringWithFormat:@"channels/%@/videos?page=%ld&per_page=15",videoID,(long)pageNumber] ;
    
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            
            failure(task, error);
        }
    }];
}



@end

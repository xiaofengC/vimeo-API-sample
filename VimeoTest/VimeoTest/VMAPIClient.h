//
//  VMAPIClient.h
//  VimeoTest
//
//  Created by Xiaofeng Chen on 12/6/14.
//  Copyright (c) 2014 Xiaofeng Chen. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface VMAPIClient : AFHTTPSessionManager

+ (VMAPIClient*)sharedClient;


- (void)getVideoListWithId:(NSString *)videoID Page:(NSInteger)pageNumber to:(NSMutableArray*)toArray success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;
@end

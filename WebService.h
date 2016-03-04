//
//  WebService.h
//  AcroFind
//
//  Created by Sri Varsha on 3/3/16.
//  Copyright © 2016 Sree. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "acro.h"



typedef void (^Success)(NSURLSessionDataTask *task, acro *acronym);
typedef void (^Failure)(NSURLSessionDataTask *task, NSError *error);


@interface WebService : AFHTTPSessionManager

+ (WebService *) sharedManager;


- (void)getResponse:(NSString *)urlString Parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;

@end

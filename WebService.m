//
//  WebService.m
//  AcroFind
//
//  Created by Sri Varsha on 3/3/16.
//  Copyright © 2016 Sree. All rights reserved.
//

#import "WebService.h"
#import "acro.h"



@implementation WebService

+ (WebService *)sharedManager {
    
    static WebService *sharedManager = nil;
    
    static dispatch_once_t once ;
    
    dispatch_once(&once, ^{
        sharedManager = [[WebService alloc] init];
    });
    
    return sharedManager;
}


- (id)init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    return self;
}


- (void)getResponse: (NSString *)urlString Parameters:(NSDictionary *) parameters success:(Success) success failure:(Failure) failure
{
    
   
    self.responseSerializer.acceptableContentTypes = nil;
    
    [self GET:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject){
        if (success) {
            success(task, [self parseResponseObject:responseObject]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

- (acro *)parseResponseObject:(id)responseObject {
    
    if([responseObject isKindOfClass:[NSArray class]] && [responseObject count] > 0 ){
        for(NSDictionary *dict in responseObject){
            
       
            
            acro *acronym = [[acro alloc] init];
            [acronym setSForm:[dict objectForKey:@"sf"]] ;
            [acronym setResults:[self getResults:[dict objectForKey:@"lfs"]]];
            return acronym;
        }
        
    }
    return nil;
}
- (NSMutableArray *)getResults:(NSMutableArray *)arr {
    NSMutableArray *resultArray = [NSMutableArray array];
    for(NSDictionary *dict in arr){
        
        acro *acronym = [[acro alloc] initWithDictionary:dict];
        [resultArray addObject:acronym];
    }
    return resultArray;
}

@end

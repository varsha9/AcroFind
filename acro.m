//
//  acro.m
//  AcroFind
//
//  Created by Sri Varsha on 3/3/16.
//  Copyright © 2016 Sree. All rights reserved.
//

#import "acro.h"

@implementation acro


- (id)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        if (dict) {
            [self setResults:[dict objectForKey:@"lf"]];
            [self setFreq: [[dict objectForKey:@"freq"] integerValue]] ;
            [self setSince: [[dict objectForKey:@"since"] integerValue]] ;
            [self setVars:[self getVars:[dict objectForKey:@"vars"]]];
        }
        return self;
    }
    return nil;
}

- (NSMutableArray *) getVars:(NSMutableArray *) arr {
    NSMutableArray *varsArray = [NSMutableArray array];
    for(NSDictionary *dict in arr){
        
        acro *result = [[acro alloc] init];
        [result setResults: [dict objectForKey:@"lf"]] ;
        [result setFreq: [[dict objectForKey:@"freq"] integerValue]] ;
        [result setSince: [[dict objectForKey:@"since"] integerValue]] ;
        
        [varsArray addObject:result];
    }
    return varsArray;
}


@end

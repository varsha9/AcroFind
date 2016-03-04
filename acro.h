//
//  acro.h
//  AcroFind
//
//  Created by Sri Varsha on 3/3/16.
//  Copyright © 2016 Sree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface acro : NSObject


@property (nonatomic, copy) NSString *sForm;
@property (nonatomic, strong) NSMutableArray *results;

@property (nonatomic, copy) NSString *lForm;
@property NSInteger freq;
@property NSInteger since;
@property (nonatomic, copy) NSMutableArray *vars;

- (id)initWithDictionary:(NSDictionary *)dict;

@end

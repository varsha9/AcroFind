//
//  Consts.h
//  AcroFind
//
//  Created by Sri Varsha on 3/3/16.
//  Copyright © 2016 Sree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Consts : NSObject

extern NSString *const aBaseURL;

extern NSString *const kAppFontName;
extern NSString *const kAppBoldFontName;

#define labelTextFont [UIFont fontWithName:kAppFontName size:20.0f]
#define labelBoldTextFont [UIFont fontWithName:kAppBoldFontName size:20.0f]
#define descriptionTextFont [UIFont fontWithName:kAppFontName size:15.0f]
#define cellVerticalPadding 15
#define cellHorizontalWaste 60



@end

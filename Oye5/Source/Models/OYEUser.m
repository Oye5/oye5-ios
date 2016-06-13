//
//  OYEUser.m
//  Oye5
//
//  Created by Rita Kyauk on 3/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEUser.h"
#import "NSObject+Motis.h"

@implementation OYEUser

+ (NSDictionary*)mts_mapping {
    return @{@"userID":mts_key(userID),
             @"name":mts_key(name),
             @"firstName":mts_key(firstName),
             @"middleName":mts_key(middleName),
             @"lastName":mts_key(lastName),
             @"imageURL":mts_key(imageURL),
             @"email":mts_key(email),
             @"numberOfReviews":mts_key(numberOfReviews)
    };
}

@end

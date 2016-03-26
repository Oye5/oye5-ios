//
//  OYELocation.m
//  Oye5
//
//  Created by Rita Kyauk on 3/25/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYELocation.h"
#import "NSObject+Motis.h"

@interface OYELocation ()

@property (nonatomic, assign) CLLocationDegrees latitude;
@property (nonatomic, assign) CLLocationDegrees longitude;

@end

@implementation OYELocation

+ (NSDictionary*)mts_mapping {
    return @{@"latitude":mts_key(latitude),
             @"longitude":mts_key(longitude),
             @"city":mts_key(city),
             @"state":mts_key(state),
             @"country":mts_key(country),
             @"postalCode":mts_key(postalCode)
             };
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

@end

//
//  OYELocation.h
//  Oye5
//
//  Created by Rita Kyauk on 3/25/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import CoreLocation;

#import "MTSMotisObject.h"

@interface OYELocation : MTSMotisObject

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *postalCode;

- (CLLocationCoordinate2D)coordinate;

@end

//
//  OYEUserLocationManager.h
//  Oye5
//
//  Created by Rita Kyauk on 5/15/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

@interface OYEUserLocationManager : NSObject

+ (CLLocation *)currentLocation;

@end

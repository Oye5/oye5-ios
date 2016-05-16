//
//  OYEUserLocationManager.m
//  Oye5
//
//  Created by Rita Kyauk on 5/15/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "OYEUserLocationManager.h"

@interface OYEUserLocationManager () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation OYEUserLocationManager

+ (OYEUserLocationManager *)sharedInstance {
    __strong static OYEUserLocationManager *_sharedInstance;
    static dispatch_once_t predicate = 0;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [self new];
        
        [_sharedInstance setupLocationManager];
    });
    
    return _sharedInstance;
}

+ (CLLocation *)currentLocation {
    return [self sharedInstance].locationManager.location;
}

#pragma mark - Private

- (void)setupLocationManager {
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locationManager.distanceFilter = 100.0;
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    DDLogDebug(@"*");
}

@end

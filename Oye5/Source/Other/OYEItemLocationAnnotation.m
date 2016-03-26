//
//  OYEItemLocationAnnotation.m
//  Oye5
//
//  Created by Rita Kyauk on 3/16/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import MapKit;

#import "OYEItemLocationAnnotation.h"
#import "OYEItem.h"
#import "OYELocation.h"

@interface OYEItemLocationAnnotation ()

@property (nonatomic, strong) OYEItem *item;

@end

@implementation OYEItemLocationAnnotation

+ (instancetype)annotationWithItem:(OYEItem *)item {
    OYEItemLocationAnnotation *instance = [OYEItemLocationAnnotation new];
    
    instance.item = item;
    
    return instance;
}

#pragma mark - MKAnnotation

- (CLLocationCoordinate2D)coordinate {
    return self.item.location.coordinate;
}

- (NSString *)title {
    return self.item.itemTitle;
}

- (NSString *)subtitle {
    return [NSString stringWithFormat:@"%@, %@, %@, %@", self.item.location.city, self.item.location.state, self.item.location.country, self.item.location.postalCode];
}

@end

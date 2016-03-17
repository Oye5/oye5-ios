//
//  OYEItem.h
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;
@class CLLocation;

@interface OYEItem : NSObject

@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, strong) NSArray<NSString *> *images;
@property (nonatomic, strong) NSString *currencyCode;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *postalCode;

- (NSString *)priceString;

@end

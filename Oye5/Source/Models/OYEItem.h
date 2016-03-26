//
//  OYEItem.h
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MTSMotisObject.h"

@class OYELocation;

@interface OYEItem : MTSMotisObject

@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, strong) NSArray<NSString *> *images;
@property (nonatomic, strong) NSString *currencyCode;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) OYELocation *location;

- (NSString *)priceString;

@end

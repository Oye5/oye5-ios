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
@class OYEUser;

@interface OYEItem : MTSMotisObject

@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, strong) NSArray<NSString *> *images;
@property (nonatomic, strong) NSString *currencyCode;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) OYELocation *location;
@property (nonatomic, strong) OYEUser *seller;
@property (nonatomic, strong) NSString *condition;
@property (nonatomic, strong) NSDate *addedDate;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSArray *tags;

- (NSString *)priceString;

@end

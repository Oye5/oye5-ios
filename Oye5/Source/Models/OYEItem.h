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

@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *currencyCode;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) CLLocation *location;

- (NSString *)priceString;

@end

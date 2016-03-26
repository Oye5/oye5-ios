//
//  OYEItem.m
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEItem.h"
#import "NSObject+Motis.h"

@implementation OYEItem

+ (NSDictionary*)mts_mapping {
    return @{@"title":mts_key(itemTitle),
             @"description":mts_key(itemDescription),
             @"images":mts_key(images),
             @"currencyCode":mts_key(currencyCode),
             @"price":mts_key(price),
             @"location":mts_key(location)
             };
}

- (NSString *)priceString {
    static NSNumberFormatter *numberFormatter;
    @synchronized([OYEItem class]) {
        if (!numberFormatter) {
            numberFormatter = [NSNumberFormatter new];
        }
        numberFormatter.currencyCode = self.currencyCode;
        numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    }
    
    return [NSString stringWithFormat:@"%@", [numberFormatter stringFromNumber:self.price]];

}

@end

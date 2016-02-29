//
//  OYEItem.m
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEItem.h"

@implementation OYEItem

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

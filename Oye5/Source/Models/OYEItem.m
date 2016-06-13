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
             @"location":mts_key(location),
             @"seller":mts_key(seller),
             @"condition":mts_key(condition),
             @"addedDate":mts_key(addedDate),
             @"category":mts_key(category),
             @"tags":mts_key(tags)};
}

+ (NSDateFormatter *)mts_validationDateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    });
    
    return dateFormatter;
}

- (BOOL)mts_validateValue:(inout __autoreleasing id *)ioValue forKey:(NSString *)inKey error:(out NSError *__autoreleasing *)outError {
    // Check *ioValue and assign new value to ioValue if needed.
    // Return YES if *ioValue can be assigned to the attribute, NO otherwise
    DDLogDebug(@"inKey: %@ ioValue: %@", inKey, *ioValue);
    
    return YES;
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

//
//  OYEItemManager.m
//  Oye5
//
//  Created by Rita Kyauk on 3/19/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import CoreLocation;

#import "OYEItemManager.h"
#import "OYEItem.h"
#import "NSObject+Motis.h"

@implementation OYEItemManager

+ (NSArray *)itemsJson {
    NSMutableArray *items = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 100; i++) {
        NSMutableDictionary *anItem = [NSMutableDictionary dictionary];
        
        anItem[@"title"] = [NSString stringWithFormat:@"Title %ld", (long)i];
        anItem[@"description"] = [NSString stringWithFormat:@"Item %ld is new.", (long)i];
        anItem[@"images"] = @[@"http://moviecitynews.com/wp-content/uploads/2015/06/inside-out-651.jpg",
                          @"https://cdn.amctheatres.com/titles/images/Poster/Large/2472_io-superticket-1sht-comp24a_B756.jpg",
                          @"https://cdn.amctheatres.com/Media/Default/images/Inside-Out-Meet-your-emotions-2.png",
                          @"https://cdn.amctheatres.com/Media/Default/images/insideout.jpg",
                          @"https://cdn.amctheatres.com/Media/Default/images/Inside%20Out.jpg",
                          @"https://cdn.amctheatres.com/titles/images/Hero/HeroLarge/2591_movie-featured-insideout-104_D7EA.jpg"];
        anItem[@"currencyCode"] = @"INR";
        anItem[@"price"] = @(i);

        anItem[@"location"] = @{@"latitude":@"18.9750",
                                @"longitude":@"72.8258",
                                @"city":@"Mumbai",
                                @"state":@"India",
                                @"postalCode":@"12345"};
        
        [items addObject:anItem];
    }
    
    return items;
}

+ (NSArray<OYEItem *> *)getItems {
//    static NSArray<OYEItem *> *items;
//    
//    if (!items) {
//        NSMutableArray<OYEItem *> *mutableItems = [NSMutableArray array];
//        for (NSInteger i = 0; i < 100; i++) {
//            OYEItem *anItem = [OYEItem new];
//            anItem.itemTitle = [NSString stringWithFormat:@"Title %ld", (long)i];
//            anItem.itemDescription = [NSString stringWithFormat:@"Item %ld is new.", (long)i];
//            NSMutableArray *images = [NSMutableArray array];
//            for (NSInteger i = 0; i < 12; i++) {
//                [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"image-%ld", (long)i]]];
//            }
//            anItem.images = @[@"http://moviecitynews.com/wp-content/uploads/2015/06/inside-out-651.jpg",
//                              @"https://cdn.amctheatres.com/titles/images/Poster/Large/2472_io-superticket-1sht-comp24a_B756.jpg",
//                              @"https://cdn.amctheatres.com/Media/Default/images/Inside-Out-Meet-your-emotions-2.png",
//                              @"https://cdn.amctheatres.com/Media/Default/images/insideout.jpg",
//                              @"https://cdn.amctheatres.com/Media/Default/images/Inside%20Out.jpg",
//                              @"https://cdn.amctheatres.com/titles/images/Hero/HeroLarge/2591_movie-featured-insideout-104_D7EA.jpg"];
//            anItem.currencyCode = @"INR";
//            anItem.price = @(i);
//            
//            anItem.city = @"Mumbai";
//            anItem.state = @"Maharashtra";
//            anItem.country = @"India";
//            anItem.postalCode = @"12345";
//            anItem.location = [[CLLocation alloc] initWithLatitude:18.9750 longitude:72.8258];
//            
//            [mutableItems addObject:anItem];
//        }
//        
//        items = mutableItems;
//    }
    
    NSArray *itemsJson = [self itemsJson];
    NSMutableArray<OYEItem *> *items = [NSMutableArray<OYEItem *> array];
    
    for (NSDictionary *anItemJson in itemsJson) {
        OYEItem *item = [OYEItem new];
        
        // Parsing and setting the values of the JSON object
        [item mts_setValuesForKeysWithDictionary:anItemJson];
        
        [items addObject:item];
    }
    
    return items;
   
}

@end

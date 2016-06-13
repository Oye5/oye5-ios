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
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    
    NSArray *imageURLs = @[@"http://www.kungfupandamovie-ph.com/img/gallery/gallery8.jpg",
                           @"http://moviecitynews.com/wp-content/uploads/2015/06/inside-out-651.jpg",
                           @"https://cdn.amctheatres.com/titles/images/Poster/Large/2472_io-superticket-1sht-comp24a_B756.jpg",
                           @"https://cdn.amctheatres.com/Media/Default/images/Inside-Out-Meet-your-emotions-2.png",
                           @"https://cdn.amctheatres.com/Media/Default/images/insideout.jpg",
                           @"https://cdn.amctheatres.com/Media/Default/images/Inside%20Out.jpg",
                           @"https://cdn.amctheatres.com/titles/images/Hero/HeroLarge/2591_movie-featured-insideout-104_D7EA.jpg",
                           @"http://www.kungfupandamovie-ph.com/img/gallery/gallery9.jpg",
                           @"http://www.kungfupandamovie-ph.com/img/gallery/gallery10.jpg",
                           @"http://www.kungfupandamovie-ph.com/img/gallery/gallery11.jpg",
                           @"http://www.kungfupandamovie-ph.com/img/gallery/gallery12.jpg"];
    NSMutableArray *items = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 100; i++) {
        NSMutableDictionary *anItem = [NSMutableDictionary dictionary];
        
        anItem[@"title"] = [NSString stringWithFormat:@"Title of item %ld", (long)i];
        anItem[@"description"] = [NSString stringWithFormat:@"Item %ld is new.", (long)i];
        NSMutableArray *randomImageURLs = [NSMutableArray array];
        for (NSInteger j = 0; j < imageURLs.count; j++) {
            NSInteger randomIndex;
            while ([randomImageURLs containsObject:imageURLs[randomIndex = (rand() % imageURLs.count)]]);
            [randomImageURLs addObject:imageURLs[randomIndex]];
        }
        anItem[@"images"] = [randomImageURLs copy];
        anItem[@"currencyCode"] = @"INR";
        anItem[@"price"] = @(i + 10);

        anItem[@"location"] = @{@"latitude":@"18.9750",
                                @"longitude":@"72.8258",
                                @"city":@"Mumbai",
                                @"state":@"India",
                                @"postalCode":@"12345"};
        anItem[@"seller"] = @{@"userID":@"12345",
                              @"name":@"Robert Williamson",
                              @"firstName":@"Robert",
                              @"lastName":@"Williamson",
                              @"imageURL":@"http://www.kungfupandamovie-ph.com/img/gallery/gallery0.jpg",
                              @"email":@"robert.williamson@oye.com",
                              @"numberOfReviews":@"100"};
        anItem[@"condition"] = @"Brand New";
        
        anItem[@"addedDate"] = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:(i * -3600)]];
        anItem[@"category"] = @"Fashion";
        anItem[@"tags"] = @[@"Nike", @"Running", @"Shoes"];
        
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
 
    
    // Testing request
//    [[self manager] GET:@"https://api.github.com/users/mralexgray/repos" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        DDLogDebug(@"JSON: %@", responseObject);
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        DDLogDebug(@"Error: %@", error);
//    }];
    
    
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

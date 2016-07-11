//
//  OYEUserDefaultsManager.m
//  Oye5
//
//  Created by Rita Kyauk on 7/10/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEUserDefaultsManager.h"

static NSString * const OYEUserDefaultsFilterDistance = @"OYEUserDefaultsFilterDistance";
static NSString * const OYEUserDefaultsFilterSortByType = @"OYEUserDefaultsFilterSortByType";
static NSString * const OYEUserDefaultsFilterCategories = @"OYEUserDefaultsFilterCategories";

static CGFloat OYEUserDefaultsInitialFilterDistanceInKilometers = 5.0;

@implementation OYEUserDefaultsManager

+ (void)setFilterDistance:(CGFloat)distance {
    [[NSUserDefaults standardUserDefaults] setObject:@(distance) forKey:OYEUserDefaultsFilterDistance];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setFilterSortByType:(OYEFilterSortByType)filterSortByType {
    [[NSUserDefaults standardUserDefaults] setObject:@(filterSortByType) forKey:OYEUserDefaultsFilterSortByType];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setFilterCategories:(NSUInteger)filterCategories {
    [[NSUserDefaults standardUserDefaults] setObject:@(filterCategories) forKey:OYEUserDefaultsFilterCategories];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setFilterCategory:(OYEFilterCategoryType)filterCategory {
    NSUInteger categories = [[[NSUserDefaults standardUserDefaults] objectForKey:OYEUserDefaultsFilterCategories] unsignedIntegerValue];
    categories |= filterCategory;
    
    [[NSUserDefaults standardUserDefaults] setObject:@(categories) forKey:OYEUserDefaultsFilterCategories];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)unsetFilterCategory:(OYEFilterCategoryType)filterCategory {
    NSUInteger categories = [[[NSUserDefaults standardUserDefaults] objectForKey:OYEUserDefaultsFilterCategories] unsignedIntegerValue];
    categories &= ~filterCategory;
    
    [[NSUserDefaults standardUserDefaults] setObject:@(categories) forKey:OYEUserDefaultsFilterCategories];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (CGFloat)filterDistance {
    NSNumber *distance = [[NSUserDefaults standardUserDefaults] objectForKey:OYEUserDefaultsFilterDistance];
    if (distance) {
        return distance.floatValue;
    } else {
        return OYEUserDefaultsInitialFilterDistanceInKilometers;
    }
}

+ (OYEFilterSortByType)filterSortType {
    NSNumber *sortByType = [[NSUserDefaults standardUserDefaults] objectForKey:OYEUserDefaultsFilterSortByType];
    if (sortByType) {
        return sortByType.unsignedIntegerValue;
    } else {
        return OYEFilterSortByTypeNewestFirst;
    }
}

+ (NSUInteger)filterCategories {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:OYEUserDefaultsFilterCategories] unsignedIntegerValue];
}

+ (BOOL)isSetFilterCategory:(OYEFilterCategoryType)filterCategoryType {
    NSUInteger categorites = [[[NSUserDefaults standardUserDefaults] objectForKey:OYEUserDefaultsFilterCategories] unsignedIntegerValue];
    
    return ((categorites & filterCategoryType) > 0);
}

@end

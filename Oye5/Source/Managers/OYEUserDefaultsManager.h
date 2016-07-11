//
//  OYEUserDefaultsManager.h
//  Oye5
//
//  Created by Rita Kyauk on 7/10/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, OYEFilterSortByType) {
    OYEFilterSortByTypeNewestFirst,
    OYEFilterSortByTypePriceLowToHigh,
    OYEFilterSortByTypePriceHighToLow
};

typedef NS_ENUM(NSUInteger, OYEFilterCategoryType) {
    OYEFilterCategoryTypeElectronics = 1 << 1,
    OYEFilterCategoryTypeFashionAndAccessories = 1 << 2,
    OYEFilterCategoryTypeHomeAndGarden = 1 << 3,
    OYEFilterCategoryTypeBooksMoviesAndMusic = 1 << 4,
    OYEFilterCategoryTypeSportsAndLeisure = 1 << 5,
    OYEFilterCategoryTypeCarsAndMotors = 1 << 6,
    OYEFilterCategoryTypeBabyAndChild = 1 << 7,
    OYEFilterCategoryTypeOther = 1 << 8
};

@interface OYEUserDefaultsManager : NSObject

+ (void)setFilterDistance:(CGFloat)distance;
+ (void)setFilterSortByType:(OYEFilterSortByType)filterSortByType;
+ (void)setFilterCategories:(NSUInteger)filterCategories;
+ (void)setFilterCategory:(OYEFilterCategoryType)filterCategory;
+ (void)unsetFilterCategory:(OYEFilterCategoryType)filterCategory;

+ (CGFloat)filterDistance;
+ (OYEFilterSortByType)filterSortType;
+ (NSUInteger)filterCategories;

@end

//
//  OYEBaseCollectionViewCell.m
//  Oye5
//
//  Created by Rita Kyauk on 6/18/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEBaseCollectionViewCell.h"

NSString * const OYECollectionViewCellHeightItemKey = @"OYECollectionViewCellHeightItem";
NSString * const OYECollectionViewCellHeightWidthKey = @"OYECollectionViewCellHeightWidth";

@implementation OYEBaseCollectionViewCell

+ (CGFloat)cellHeight:(NSDictionary *)data {
    return 44;
}

@end

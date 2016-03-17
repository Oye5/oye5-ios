//
//  OYEBaseTableViewCell.m
//  Oye5
//
//  Created by Rita Kyauk on 3/13/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEBaseTableViewCell.h"

NSString * const OYETableViewCellHeightItemKey = @"OYETableViewCellHeightItem";
NSString * const OYETableViewCellHeightWidthKey = @"OYETableViewCellHeightWidth";

@implementation OYEBaseTableViewCell

+ (CGFloat)cellHeight:(NSDictionary *)data {
    return 44;
}

@end

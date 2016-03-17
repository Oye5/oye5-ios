//
//  OYEBaseTableViewCell.h
//  Oye5
//
//  Created by Rita Kyauk on 3/13/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const OYETableViewCellHeightItemKey;
extern NSString * const OYETableViewCellHeightWidthKey;

@interface OYEBaseTableViewCell : UITableViewCell

+ (CGFloat)cellHeight:(NSDictionary *)data;

@end

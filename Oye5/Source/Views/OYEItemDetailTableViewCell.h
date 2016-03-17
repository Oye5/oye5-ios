//
//  OYEItemDetailTableViewCell.h
//  Oye5
//
//  Created by Rita Kyauk on 3/13/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OYEBaseTableViewCell.h"

@class OYEItem;

@interface OYEItemDetailTableViewCell : OYEBaseTableViewCell

- (void)setItem:(OYEItem *)item;

@end

//
//  OYEItemShareTableViewCell.h
//  Oye5
//
//  Created by Rita Kyauk on 3/26/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OYEBaseTableViewCell.h"

@protocol OYEItemShareTableViewCellDelegate <NSObject>

- (void)didSelectEMailButton;

@end

@class OYEItem;

@interface OYEItemShareTableViewCell : OYEBaseTableViewCell

- (void)setDelegate:(id<OYEItemShareTableViewCellDelegate>)delegate;
- (void)setItem:(OYEItem *)item;

@end

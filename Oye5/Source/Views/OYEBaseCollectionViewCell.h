//
//  OYEBaseCollectionViewCell.h
//  Oye5
//
//  Created by Rita Kyauk on 6/18/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const OYECollectionViewCellHeightItemKey;
extern NSString * const OYECollectionViewCellHeightWidthKey;

@interface OYEBaseCollectionViewCell : UICollectionViewCell

+ (CGFloat)cellHeight:(NSDictionary *)data;

@end

//
//  OYECategoryCollectionViewCell.m
//  Oye5
//
//  Created by Rita Kyauk on 9/4/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYECategoryCollectionViewCell.h"

@implementation OYECategoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
    
    self.backgroundColor = [UIColor oyeMediumBackgroundColor];
    self.titleLabel.font = [UIFont mediumOyeFontOfSize:16.0];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds = YES;
}

@end

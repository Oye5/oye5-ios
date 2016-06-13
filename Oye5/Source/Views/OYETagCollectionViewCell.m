//
//  OYETagCollectionViewCell.m
//  Oye5
//
//  Created by Rita Kyauk on 6/12/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYETagCollectionViewCell.h"
#import "UIFont+Extensions.h"
#import "UIColor+Extensions.h"

@implementation OYETagCollectionViewCell

+ (UIFont *)font {
    return [UIFont oyeFontOfSize:12];
}

- (void)awakeFromNib {
    // Initialization code
    self.nameLabel.font = [[self class] font];
    self.nameLabel.textColor = [UIColor oyeDarkTextColor];
    self.nameLabel.layer.borderColor = [UIColor oyeDarkTextColor].CGColor;
    self.nameLabel.layer.borderWidth = 1.0;
    self.nameLabel.layer.cornerRadius = 2.0;
    self.nameLabel.layer.masksToBounds = YES;
}

@end

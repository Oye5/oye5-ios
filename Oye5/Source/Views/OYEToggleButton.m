//
//  OYEToggleButton.m
//  Oye5
//
//  Created by Rita Kyauk on 7/9/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEToggleButton.h"
#import "UIImage+Extensions.h"

@implementation OYEToggleButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    [self setupUI];
    
    return self;
}

- (void)setupUI {
    [self setImage:[UIImage imageNamed:@"checkbox-unselected"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"checkbox-selected"] forState:UIControlStateSelected];
    
    [self setTitleColor:[UIColor oyeDarkTextColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor oyeDarkTextColor] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor oyeDarkTextColor] forState:UIControlStateHighlighted];
    self.titleLabel.font = [UIFont oyeFontOfSize:14.0];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.numberOfLines = 0;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}

@end

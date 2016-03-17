//
//  UIButton+Extensions.m
//  Oye5
//
//  Created by Rita Kyauk on 3/13/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "UIButton+Extensions.h"
#import "UIFont+Extensions.h"
#import "UIColor+Extensions.h"

@implementation UIButton (Extensions)

- (void)setupAsPrimaryButton {
    [self setupBasics];
    [self setTitleColor:[UIColor oyeLightTextColor] forState:UIControlStateNormal];

    self.backgroundColor = [UIColor oyeDarkTextColor];
}

- (void)setupAsSecondaryButton {
    [self setupWithBorderColor:[UIColor oyeDarkTextColor]];
}

- (void)setupWithBorderColor:(UIColor *)color {
    [self setupBasics];
    
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 1;

    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)setupBasics {
    self.layer.cornerRadius = 2;
    self.titleLabel.font = [UIFont oyeFontOfSize:16];
}

@end

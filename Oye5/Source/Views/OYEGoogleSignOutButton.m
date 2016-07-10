//
//  OYEGoogleSignOutButton.m
//  Oye5
//
//  Created by Rita Kyauk on 5/7/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <GoogleSignIn/GoogleSignIn.h>

#import "OYEGoogleSignOutButton.h"

static CGFloat const OYEGoogleLogoSize = 18.0;

@implementation OYEGoogleSignOutButton

+ (instancetype)button {
    return [[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setTitle:NSLocalizedString(@"Log out", nil) forState:UIControlStateNormal];
    [self setTitleColor:[UIColor oyeLightTextColor] forState:UIControlStateNormal];
    [self addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel.font = [UIFont googleFontOfSize:14];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.size = CGSizeMake(OYEGoogleLogoSize, OYEGoogleLogoSize);
    self.backgroundColor = [UIColor colorWithRed:[UIColor colorComponentWithValue:66.0] green:[UIColor colorComponentWithValue:133.0] blue:[UIColor colorComponentWithValue:244.0] alpha:1.0];
    self.layer.cornerRadius = 3.0;
    self.layer.masksToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)didTapButton:(UIButton *)button {
    DDLogDebug(@"*");
    
    [[GIDSignIn sharedInstance] disconnect];
}

@end

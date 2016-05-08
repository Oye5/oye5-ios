//
//  OYEGoogleSignOutButton.m
//  Oye5
//
//  Created by Rita Kyauk on 5/7/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <GoogleSignIn/GoogleSignIn.h>

#import "OYEGoogleSignOutButton.h"

@implementation OYEGoogleSignOutButton

- (void)dealloc {
    DDLogDebug(@"*");
}

- (instancetype)init {
    self = [[NSBundle bundleForClass:[OYEGoogleSignOutButton class]] loadNibNamed:NSStringFromClass([OYEGoogleSignOutButton class]) owner:nil options:nil].firstObject;
    if (self) {
        [self setTitle:NSLocalizedString(@"Log Out Google", nil) forState:UIControlStateNormal];
        [self addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
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

//
//  OYETitleCollectionReusableView.m
//  Oye5
//
//  Created by Rita Kyauk on 6/19/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYETitleCollectionReusableView.h"
#import "OYEUnderlineButton.h"

@interface OYETitleCollectionReusableView ()

@property (nonatomic, strong) OYEUnderlineButton *titleView;

@end

@implementation OYETitleCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSString *title = NSLocalizedString(@"Similar Items", nil);

        self.titleView = [[NSBundle bundleForClass:[OYEUnderlineButton class]] loadNibNamed:NSStringFromClass([OYEUnderlineButton class]) owner:self options:nil].firstObject;
        self.titleView.selected = YES;
        self.titleView.userInteractionEnabled = NO;
        
        [self.titleView setTitle:title forState:UIControlStateNormal];

        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:self.titleView.titleLabel.font}];
        CGFloat titleHeight = titleSize.height + 16;
        self.titleView.width = titleSize.width;
        self.titleView.height = titleHeight;
        self.titleView.top = (self.height - self.titleView.height) / 2.0;
        self.titleView.left = (self.width - titleSize.width) / 2.0;

        [self addSubview:self.titleView];

        // Center X
        NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.titleView
                                                                             attribute:NSLayoutAttributeCenterX
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self
                                                                             attribute:NSLayoutAttributeCenterX
                                                                            multiplier:1.0
                                                                              constant:0.0];
        
        // Center Y
        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.titleView
                                                                             attribute:NSLayoutAttributeCenterY
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self
                                                                             attribute:NSLayoutAttributeCenterY
                                                                            multiplier:1.0 constant:0.0];
        
        // Width
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.titleView
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1.0
                                                                            constant:titleSize.width];
        
        // Height
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.titleView
                                                                            attribute:NSLayoutAttributeWidth
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1.0
                                                                             constant:titleHeight];
        // Add constraints
        [self addConstraint:centerXConstraint];
        [self addConstraint:centerYConstraint];
        [self.titleView addConstraint:widthConstraint];
        [self.titleView addConstraint:heightConstraint];
    }
    
    return self;
}

@end

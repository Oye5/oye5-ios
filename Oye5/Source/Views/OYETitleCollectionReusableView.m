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
        self.titleView.width = titleSize.width;
        self.titleView.top = 0.0;
        self.titleView.left = (self.width - titleSize.width) / 2.0;
        

        [self addSubview:self.titleView];

        // Top
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        
        // Center
        NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
        
        // Height
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
        
        // Width
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];

        widthConstraint = [NSLayoutConstraint constraintWithItem:self.titleView
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute 
                                                        multiplier:1.0 
                                                          constant:titleSize.width];
        // Add constraints
        [self addConstraint:topConstraint];
        [self addConstraint:centerXConstraint];
        [self addConstraint:heightConstraint];
        [self addConstraint:widthConstraint];        
    }
    
    return self;
}

@end

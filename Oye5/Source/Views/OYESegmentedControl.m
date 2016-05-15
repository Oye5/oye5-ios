//
//  OYESegmentedControl.m
//  Oye5
//
//  Created by Rita Kyauk on 5/14/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYESegmentedControl.h"
#import "OYEUnderlineButton.h"

@interface OYESegmentedControl ()

@property (weak, nonatomic) id<OYESegmentedControlDelegate> delegate;
@property (weak, nonatomic) OYEUnderlineButton *selectedButton;

@end

@implementation OYESegmentedControl

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles delegate:(id<OYESegmentedControlDelegate>)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        CGSize segmentSize = CGSizeMake((CGRectGetWidth(frame) / titles.count), CGRectGetHeight(frame));
        for (NSInteger i = 0; i < titles.count; i++) {
             OYEUnderlineButton *button = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OYEUnderlineButton class]) owner:self options:nil] firstObject];
            button.frame = CGRectMake((i * segmentSize.width), 0, segmentSize.width, segmentSize.height);
            
            [button setTitle:titles[i] forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(didTapSegment:) forControlEvents:UIControlEventTouchUpInside];
                        
            button.translatesAutoresizingMaskIntoConstraints = NO;
            
            UIView *lastButton = self.subviews.lastObject;

            [self addSubview:button];
            
            // Top
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
            
            // Leading
            UIView *toItem = lastButton ?: self;
            NSLayoutAttribute toAttribute = lastButton ? NSLayoutAttributeTrailing : NSLayoutAttributeLeading;
            NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:toItem attribute:toAttribute multiplier:1.0 constant:0.0];
            
            // Height
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
            
            // Width
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:(1.0 / titles.count) constant:0.0];
            
            [self addConstraint:topConstraint];
            [self addConstraint:leadingConstraint];
            [self addConstraint:heightConstraint];
            [self addConstraint:widthConstraint];
        }
    }
    
    return self;
}

- (void)selectSegment:(NSUInteger)segment {
    if (self.subviews.count > segment) {
        ((OYEUnderlineButton *)self.subviews[segment]).selected = YES;
        
        self.selectedButton = self.subviews[segment];
    }
}

#pragma mark - Actions

- (void)didTapSegment:(OYEUnderlineButton *)sender {
    if (!sender.selected) {
        self.selectedButton.selected = NO;
        
        sender.selected = YES;
        
        self.selectedButton = sender;
        
        if ([self.delegate respondsToSelector:@selector(didSelectSegment:)]) {
            [self.delegate didSelectSegment:[self.subviews indexOfObject:sender]];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

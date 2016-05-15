//
//  OYESegmentedControl.h
//  Oye5
//
//  Created by Rita Kyauk on 5/14/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OYESegmentedControlDelegate <NSObject>

- (void)didSelectSegment:(NSUInteger)segment;

@end

@interface OYESegmentedControl : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles delegate:(id<OYESegmentedControlDelegate>)delegate;
- (void)selectSegment:(NSUInteger)segment;

@end

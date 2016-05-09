//
//  UIView+Extensions.h
//  Oye5
//
//  Created by Rita Kyauk on 3/26/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extensions)

- (CGFloat)top;
- (CGFloat)bottom;
- (CGFloat)left;
- (CGFloat)right;
- (CGFloat)height;
- (CGFloat)width;
- (CGSize)size;

- (void)setTop:(CGFloat)top;
- (void)setBottom:(CGFloat)bottom;
- (void)setLeft:(CGFloat)left;
- (void)setRight:(CGFloat)right;
- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width;
- (void)setOrigin:(CGPoint)origin;
- (void)setSize:(CGSize)size;

@end

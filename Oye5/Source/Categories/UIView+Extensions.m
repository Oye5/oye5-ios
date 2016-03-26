//
//  UIView+Extensions.m
//  Oye5
//
//  Created by Rita Kyauk on 3/26/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "UIView+Extensions.h"

@implementation UIView (Extensions)

- (CGFloat)top {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)bottom {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)left {
    return CGRectGetMinX(self.frame);
}

- (CGFloat)right {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - CGRectGetHeight(frame);
    
    self.frame = frame;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    
    self.frame = frame;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - CGRectGetWidth(frame);
    
    self.frame = frame;

}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    
    self.frame = frame;
}

@end

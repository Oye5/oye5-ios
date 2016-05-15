//
//  UIColor+Extensions.m
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

+ (UIColor *)oyeDarkTextColor {
    return [UIColor blackColor];
}

+ (UIColor *)oyeMediumTextColor {
    return [UIColor colorWithRed:[self colorComponentWithValue:180.0] green:[self colorComponentWithValue:181.0] blue:[self colorComponentWithValue:182.0] alpha:1.0];
}

+ (UIColor *)oyeLightTextColor {
    return [UIColor whiteColor];
}

+ (UIColor *)oyeLightGrayBackgroundColor {
    return [UIColor colorWithRed:[self colorComponentWithValue:229] green:[self colorComponentWithValue:230] blue:[self colorComponentWithValue:231] alpha:1];
}

+ (UIColor *)oyeWhiteBackGroundColor {
    return [UIColor whiteColor];
}

+ (UIColor *)oyeLineSeparatorColor {
    return [UIColor colorWithWhite:0 alpha:0.25];
}

+ (UIColor *)oyeShadowColor {
    return [UIColor colorWithWhite:0 alpha:0.25];
}

+ (CGFloat)colorComponentWithValue:(CGFloat)value {
    return (value / 255.0);
}

@end

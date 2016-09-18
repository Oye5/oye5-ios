//
//  UIColor+Extensions.m
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

+ (UIColor *)oyePrimaryColor {
    return [self oyePrimaryColorWithAlpha:1.0];
}

+ (UIColor *)oyePrimaryColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:0.0 green:[self colorComponentWithValue:191.0] blue:[self colorComponentWithValue:215.0] alpha:alpha];
}

+ (UIColor *)oyeSecondaryColor {
    return [self oyeSecondaryColorWithAlpha:1.0];
}

+ (UIColor *)oyeSecondaryColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:[self colorComponentWithValue:105.0] green:[self colorComponentWithValue:105.0] blue:[self colorComponentWithValue:105.0] alpha:alpha];
}

+ (UIColor *)oyeDarkTextColor {
    return [UIColor blackColor];
}

+ (UIColor *)oyeMediumTextColor {
    return [UIColor colorWithRed:[self colorComponentWithValue:170.0] green:[self colorComponentWithValue:171.0] blue:[self colorComponentWithValue:172.0] alpha:1.0];
}

+ (UIColor *)oyeLightTextColor {
    return [UIColor whiteColor];
}

+ (UIColor *)oyeDarkBackgroundColor {
    return [UIColor colorWithRed:[self colorComponentWithValue:25] green:[self colorComponentWithValue:20] blue:[self colorComponentWithValue:21] alpha:1];
}

+ (UIColor *)oyeMediumBackgroundColor {
    return [UIColor colorWithRed:[self colorComponentWithValue:229] green:[self colorComponentWithValue:230] blue:[self colorComponentWithValue:231] alpha:1];
}

+ (UIColor *)oyeLightBackgroundColor {
    return [UIColor whiteColor];
}

+ (UIColor *)oyeLineSeparatorColor {
    return [UIColor colorWithWhite:0 alpha:0.1];
}

+ (UIColor *)oyeShadowColor {
    return [UIColor colorWithWhite:0 alpha:0.25];
}

+ (CGFloat)colorComponentWithValue:(CGFloat)value {
    return (value / 255.0);
}

@end

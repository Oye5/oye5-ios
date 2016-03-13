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
    return [UIColor darkGrayColor];
}

+ (UIColor *)oyeMediumTextColor {
    return [UIColor grayColor];
}

+ (UIColor *)oyeLightTextColor {
    return [UIColor whiteColor];
}

+ (UIColor *)oyeBackgroundColor {
    return [UIColor lightGrayColor];
}

+ (UIColor *)oyeLineSeparatorColor {
    return [UIColor colorWithWhite:0 alpha:0.25];
}

@end

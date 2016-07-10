//
//  UIColor+Extensions.h
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extensions)

+ (UIColor *)oyePrimaryColor;
+ (UIColor *)oyePrimaryColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)oyeDarkTextColor;
+ (UIColor *)oyeMediumTextColor;
+ (UIColor *)oyeLightTextColor;
+ (UIColor *)oyeDarkBackgroundColor;
+ (UIColor *)oyeMediumBackgroundColor;
+ (UIColor *)oyeLightBackgroundColor;
+ (UIColor *)oyeLineSeparatorColor;

+ (CGFloat)colorComponentWithValue:(CGFloat)value;

@end

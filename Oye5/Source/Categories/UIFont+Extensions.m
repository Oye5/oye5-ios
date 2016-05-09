//
//  UIFont+Extensions.m
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "UIFont+Extensions.h"

static NSString * const SFUITextPrefix = @"SFUIText-";
static NSString * const SFUIDisplayPrefix = @"SFUIDisplay-";

/**
 *  SF UI Text font names
 *
 *  SFUIText-LightItalic,
 *  SFUIText-HeavyItalic,
 *  SFUIText-Bold,
 *  SFUIText-Regular,
 *  SFUIText-Italic,
 *  SFUIText-Light,
 *  SFUIText-MediumItalic,
 *  SFUIText-Semibold,
 *  SFUIText-BoldItalic,
 *  SFUIText-SemiboldItalic,
 *  SFUIText-Medium,
 *  SFUIText-Heavy
 *
 *  SF UI Display font names
 *
 *  SFUIDisplay-Light,
 *  SFUIDisplay-Heavy,
 *  SFUIDisplay-Regular,
 *  SFUIDisplay-Medium,
 *  SFUIDisplay-Bold,
 *  SFUIDisplay-Black,
 *  SFUIDisplay-Ultralight,
 *  SFUIDisplay-Thin,
 *  SFUIDisplay-Semibold
 */

@implementation UIFont (Extensions)

+ (UIFont *)oyeFontOfSize:(CGFloat)size {
    // SF font family names:  SF UI Text (SFUIText-*), SF UI Display (SFUIDisplay-*)
    return [UIFont fontWithName:[self oyeFontNameForStyle:@"Regular"] size:size];
}

+ (UIFont *)mediumOyeFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:[self oyeFontNameForStyle:@"Medium"] size:size];
}

+ (UIFont *)boldOyeFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:[self oyeFontNameForStyle:@"Bold"] size:size];
}

+ (UIFont *)googleFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Roboto-Medium" size:size];
}

+ (NSString *)oyeFontNameForStyle:(NSString *)style {
    return [NSString stringWithFormat:@"%@%@", SFUITextPrefix, style];
}

+ (NSString *)oyeHeaderFontNameForStyle:(NSString *)style {
    return [NSString stringWithFormat:@"%@%@", SFUIDisplayPrefix, style];
}

@end

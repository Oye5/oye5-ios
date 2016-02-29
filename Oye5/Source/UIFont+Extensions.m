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

@implementation UIFont (Extensions)

+ (UIFont *)oyeFontOfSize:(CGFloat)size {
    // SF font family names:  SF UI Text (SFUIText-*), SF UI Display (SFUIDisplay-*)
    return [UIFont fontWithName:[self oyeFontNameForStyle:@"Regular"] size:size];
}

+ (UIFont *)boldOyeFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:[self oyeFontNameForStyle:@"Bold"] size:size];
}

+ (NSString *)oyeFontNameForStyle:(NSString *)style {
    return [NSString stringWithFormat:@"%@%@", SFUITextPrefix, style];
}

+ (NSString *)oyeHeaderFontNameForStyle:(NSString *)style {
    return [NSString stringWithFormat:@"%@%@", SFUIDisplayPrefix, style];
}

@end

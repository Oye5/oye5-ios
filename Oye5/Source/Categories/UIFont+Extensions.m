//
//  UIFont+Extensions.m
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "UIFont+Extensions.h"

@implementation UIFont (Extensions)

+ (UIFont *)oyeFontOfSize:(CGFloat)size {
    return [UIFont systemFontOfSize:size weight:UIFontWeightRegular];
}

+ (UIFont *)mediumOyeFontOfSize:(CGFloat)size {
    return [UIFont systemFontOfSize:size weight:UIFontWeightMedium];
}

+ (UIFont *)boldOyeFontOfSize:(CGFloat)size {
    return [UIFont systemFontOfSize:size weight:UIFontWeightBold];
}

+ (UIFont *)googleFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Roboto-Medium" size:size];
}

@end

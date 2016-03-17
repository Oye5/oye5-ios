//
//  OYEItemLocationAnnotation.h
//  Oye5
//
//  Created by Rita Kyauk on 3/16/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OYEItem;

@interface OYEItemLocationAnnotation : NSObject <MKAnnotation>

+ (instancetype)annotationWithItem:(OYEItem *)item;

@end

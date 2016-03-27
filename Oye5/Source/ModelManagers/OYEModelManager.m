//
//  OYEModelManager.m
//  Oye5
//
//  Created by Rita Kyauk on 3/19/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEModelManager.h"

@implementation OYEModelManager

+ (Class)modelClass {
    NSString *modelClassName = [NSStringFromClass(self) stringByReplacingOccurrencesOfString:@"Manager" withString:@""];
    
    return NSClassFromString(modelClassName);
}

@end

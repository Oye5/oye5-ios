//
//  OYEModelManager.m
//  Oye5
//
//  Created by Rita Kyauk on 3/19/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEModelManager.h"
#import "Motis.h"

@implementation OYEModelManager

+ (instancetype)sharedManager {
    __strong static OYEModelManager *_sharedManager;
    static dispatch_once_t predicate = 0;
    
    dispatch_once(&predicate, ^{
        _sharedManager = [self new];
    });
    
    return _sharedManager;
}

+ (Class)modelClass {
    NSString *modelClassName = [NSStringFromClass(self) stringByReplacingOccurrencesOfString:@"Manager" withString:@""];
    
    return NSClassFromString(modelClassName);
}

@end

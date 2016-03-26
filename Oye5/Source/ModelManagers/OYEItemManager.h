//
//  OYEItemManager.h
//  Oye5
//
//  Created by Rita Kyauk on 3/19/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEModelManager.h"

@class OYEItem;

@interface OYEItemManager : OYEModelManager

+ (NSArray<OYEItem *> *)getItems;

@end

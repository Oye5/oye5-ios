//
//  OYEUserManager+Facebook.h
//  Oye5
//
//  Created by Rita Kyauk on 3/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OYEUserManager.h"

@class OYEUser;

@interface OYEUserManager (Facebook)

- (void)getFacebookUserWithImageSize:(CGSize)imageSize completionBlock:(void(^)(OYEUser *user, NSError *error))completionBlock;

@end

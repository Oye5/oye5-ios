//
//  OYEFacebookUserManager.h
//  Oye5
//
//  Created by Rita Kyauk on 3/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OYEUser;

@interface OYEFacebookUserManager : NSObject

+ (instancetype)manager;

- (void)getUserWithImageSize:(CGSize)imageSize completionBlock:(void(^)(OYEUser *user, NSError *error))completionBlock;

@end

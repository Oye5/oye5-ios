//
//  OYEUserManager+Google.h
//  Oye5
//
//  Created by Rita Kyauk on 5/7/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEUserManager.h"

@class OYEUser;

@interface OYEUserManager (Google)

- (OYEUser *)userFromGIDGoogleUser:(GIDGoogleUser *)googleUser withImageSize:(CGFloat)imageSize;

@end

//
//  OYEUserManager+Google.m
//  Oye5
//
//  Created by Rita Kyauk on 5/7/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <GoogleSignIn/GoogleSignIn.h>

#import "OYEUserManager+Google.h"
#import "OYEUser.h"

@implementation OYEUserManager (Google)

- (OYEUser *)userFromGIDGoogleUser:(GIDGoogleUser *)googleUser withImageSize:(CGFloat)imageSize {
    OYEUser *user = [OYEUser new];

    user.userID = googleUser.userID;
    user.token = googleUser.authentication.idToken;
    user.name = googleUser.profile.name;
    user.firstName = googleUser.profile.givenName;
    user.lastname = googleUser.profile.familyName;
    user.email = googleUser.profile.email;
    
    if (googleUser.profile.hasImage) {
        user.imageURL = [googleUser.profile imageURLWithDimension:(NSInteger)imageSize];
    }
    
    user.type = OYEUserTypeGoogle;
    
    return user;
}

@end

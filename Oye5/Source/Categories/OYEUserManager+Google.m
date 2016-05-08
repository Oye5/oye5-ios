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
    //    oyeUser.middleName = fbProfile.middleName;
    user.lastname = googleUser.profile.familyName;
    //    oyeUser.imageURL = [fbProfile imageURLForPictureMode:FBSDKProfilePictureModeSquare size:imageSize];
    // Perform any operations on signed in user here.
    //    NSString *userId = user.userID;                  // For client-side use only!
    //    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    //    NSString *fullName = user.profile.name;
    //    NSString *givenName = user.profile.givenName;
    //    NSString *familyName = user.profile.familyName;
    //    NSString *email = user.profile.email;
    // ...
    
    if (googleUser.profile.hasImage) {
        NSString *urlString = [NSString stringWithFormat:@"https://plus.google.com/s2/photos/profile/%@?sz=%f", googleUser.userID, imageSize];
        //        [[self manager] GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //            DDLogDebug(@"JSON: %@", responseObject);
        //        } failure:^(NSURLSessionTask *operation, NSError *error) {
        //            DDLogDebug(@"Error: %@", error);
        //        }];
        user.imageURL = [NSURL URLWithString:urlString];
    }
    
    user.type = OYEUserTypeGoogle;
    
    return user;
}

@end

//
//  OYEFacebookUserManager.m
//  Oye5
//
//  Created by Rita Kyauk on 3/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import FBSDKCoreKit;

#import "OYEUserManager+Facebook.h"
#import "OYEUser.h"

#import "NSObject+Motis.h"

static NSString * const OYEFacebookUserManagerErrorDomain = @"OYEFacebookUserManagerErrorDomain";
static NSInteger const OYEFacebookUserManagerErrorNotLoggedIn = -1000;

@implementation OYEUserManager (Facebook)

- (void)getFacebookUserWithImageSize:(CGSize)imageSize completionBlock:(void(^)(OYEUser *user, NSError *error))completionBlock {
    if (completionBlock && [FBSDKAccessToken currentAccessToken]) {
        if ([FBSDKProfile currentProfile]) {
            OYEUser *user = [self userFromFBSDKProfile:[FBSDKProfile currentProfile] withImageSize:imageSize];
            completionBlock(user, nil);
        } else {
            // Fields can be found at:  https://developers.facebook.com/docs/graph-api/reference/user
            NSMutableString *parameterValue = [[@[OYEUserFacebookKeyUserID,
                                                 OYEUserFacebookKeyName,
                                                 OYEUserFacebookKeyFirstName,
                                                 OYEUserFacebookKeyMiddleName,
                                                 OYEUserFacebookKeyLastName,
                                                 OYEUserFacebookKeyAbout,
                                                 OYEUserFacebookKeyBiography,
                                                 OYEUserFacebookKeyBirthday,
                                                 OYEUserFacebookKeyEmail,
                                                 OYEUserFacebookKeyGender
                                                 ] componentsJoinedByString:@","] mutableCopy];
            [parameterValue appendFormat:@",picture.width(%@).height(%@)", @(imageSize.width), @(imageSize.height)];
            
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : parameterValue}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    OYEUser *user = [OYEUser new];
                    [user mts_setValuesForKeysWithDictionary:result];
                    
                    completionBlock(user, error);
                } else {
                    completionBlock(nil, error);
                }
            }];
        }
    } else if (completionBlock) {
        completionBlock(nil, [NSError errorWithDomain:OYEFacebookUserManagerErrorDomain code:OYEFacebookUserManagerErrorNotLoggedIn userInfo:nil]);
    }
}

- (OYEUser *)userFromFBSDKProfile:(FBSDKProfile *)fbProfile withImageSize:(CGSize)imageSize {
    OYEUser *user = [OYEUser new];
    
    user.userID = fbProfile.userID;
    user.name = fbProfile.name;
    user.firstName = fbProfile.firstName;
    user.middleName = fbProfile.middleName;
    user.lastname = fbProfile.lastName;
    user.imageURL = [fbProfile imageURLForPictureMode:FBSDKProfilePictureModeSquare size:imageSize];
    user.type = OYEUserTypeFacebook;
    
    return user;
}

@end

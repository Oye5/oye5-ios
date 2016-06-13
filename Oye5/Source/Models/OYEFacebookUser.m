//
//  OYEFacebookUser.m
//  Oye5
//
//  Created by Rita Kyauk on 5/22/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEFacebookUser.h"
#import "NSObject+Motis.h"

NSString * const OYEUserFacebookKeyUserID = @"id";
NSString * const OYEUserFacebookKeyName = @"name";
NSString * const OYEUserFacebookKeyFirstName = @"first_name";
NSString * const OYEUserFacebookKeyMiddleName = @"middle_name";
NSString * const OYEUserFacebookKeyLastName = @"last_name";
NSString * const OYEUserFacebookKeyImageURL = @"";
NSString * const OYEUserFacebookKeyAbout = @"about";
NSString * const OYEUserFacebookKeyBiography = @"bio";
NSString * const OYEUserFacebookKeyBirthday = @"birthday";
NSString * const OYEUserFacebookKeyEmail = @"email";
NSString * const OYEUserFacebookKeyGender = @"gender";

@implementation OYEFacebookUser

+ (NSDictionary*)mts_mapping {
    return @{OYEUserFacebookKeyUserID:mts_key(userID),
             OYEUserFacebookKeyName:mts_key(name),
             OYEUserFacebookKeyFirstName:mts_key(firstName),
             OYEUserFacebookKeyMiddleName:mts_key(middleName),
             OYEUserFacebookKeyLastName:mts_key(lastName),
             OYEUserFacebookKeyImageURL:mts_key(imageURL),
             OYEUserFacebookKeyAbout:mts_key(about),
             OYEUserFacebookKeyBiography:mts_key(biography),
             OYEUserFacebookKeyBirthday:mts_key(birthday),
             OYEUserFacebookKeyEmail:mts_key(email),
             OYEUserFacebookKeyGender:mts_key(gender)
             };
}

@end

//
//  OYEUser.h
//  Oye5
//
//  Created by Rita Kyauk on 3/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "MTSMotisObject.h"

extern NSString * const OYEUserFacebookKeyUserID;
extern NSString * const OYEUserFacebookKeyName;
extern NSString * const OYEUserFacebookKeyFirstName;
extern NSString * const OYEUserFacebookKeyMiddleName;
extern NSString * const OYEUserFacebookKeyLastName;
extern NSString * const OYEUserFacebookKeyImageURL;
extern NSString * const OYEUserFacebookKeyAbout;
extern NSString * const OYEUserFacebookKeyBiography;
extern NSString * const OYEUserFacebookKeyBirthday;
extern NSString * const OYEUserFacebookKeyEmail;
extern NSString * const OYEUserFacebookKeyGender;

typedef NS_ENUM(NSInteger, OYEUserType) {
    OYEUserTypeNone,
    OYEUserTypeFacebook,
    OYEUserTypeGoogle
};

@interface OYEUser : MTSMotisObject

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *middleName;
@property (strong, nonatomic) NSString *lastname;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSString *about;
@property (strong, nonatomic) NSString *biography;
@property (strong, nonatomic) NSString *birthday;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *gender;
@property (assign, nonatomic) OYEUserType type;

@end

//
//  OYEUserManager.m
//  Oye5
//
//  Created by Rita Kyauk on 5/5/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import FBSDKCoreKit;

#import <GoogleSignIn/GoogleSignIn.h>

#import "OYEUserManager+Facebook.h"
#import "OYEUserManager+Google.h"
#import "OYEUser.h"

NSString * const OYEUserNotificationSignedIn = @"OYEUserNotificationSignedIn";
NSString * const OYEUserNotificationSignedOut = @"OYEUserNotificationSignedOut";

static NSString * const OYEGoogleSignInClientID = @"73170800702-mmarknahfbs4kfjpu8u1tu6pbhb3ils4.apps.googleusercontent.com";

static CGFloat const OYEUserImageSize = 100;

@interface OYEUserManager () <GIDSignInDelegate>

@property (strong, nonatomic) OYEUser *user;

@end

@implementation OYEUserManager

__strong static OYEUserManager *_sharedManager;

+ (instancetype)sharedManager {
    static dispatch_once_t predicate = 0;
    
    dispatch_once(&predicate, ^{
        _sharedManager = [self new];
    });
    
    return _sharedManager;
}

- (void)setup {
    [self setupFacebookLogin];
    [self setupGoogleLogin];
}

#pragma mark - Private

- (void)setupFacebookLogin {
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(facebookProfileDidChangeNotification:) name:FBSDKProfileDidChangeNotification object:nil];

    if ([FBSDKAccessToken currentAccessToken]) {
        [_sharedManager getFacebookUser];
    }
}

- (void)setupGoogleLogin {
    [GIDSignIn sharedInstance].clientID = OYEGoogleSignInClientID;
    [GIDSignIn sharedInstance].delegate = self;
    
    [[GIDSignIn sharedInstance] signInSilently];
//    
//    if ([[GIDSignIn sharedInstance] currentUser]) {
//        [self signInUser:[self userFromGIDGoogleUser:[[GIDSignIn sharedInstance] currentUser] withImageSize:OYEUserImageSize]];
//    }
}

- (void)getFacebookUser {
    [self getFacebookUserWithImageSize:CGSizeMake(OYEUserImageSize, OYEUserImageSize) completionBlock:^(OYEUser *user, NSError *error) {
        if (user) {
            [self signInUser:user];
        }
    }];
}

- (void)signInUser:(OYEUser *)user {
    DDLogDebug(@"*");
    
    [OYEUserManager sharedManager].user = user;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:OYEUserNotificationSignedIn object:self];
}

- (void)signOut {
    DDLogDebug(@"*");

    [OYEUserManager sharedManager].user = nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:OYEUserNotificationSignedOut object:self];
}

#pragma mark - GIDSignInDelegate

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    DDLogDebug(@"*");

    [self signInUser:[self userFromGIDGoogleUser:user withImageSize:OYEUserImageSize]];
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {
    DDLogDebug(@"*");
    
    [self signOut];
}

#pragma mark - Notifications

- (void)facebookProfileDidChangeNotification:(NSNotification *)notification {
    DDLogDebug(@"*");
    
    NSDictionary *userInfo = notification.userInfo;
    if (userInfo[FBSDKProfileChangeOldKey]) {
        [self signOut];
    } else if (userInfo[FBSDKProfileChangeNewKey]) {
        [self getFacebookUser];
    }
 }

@end

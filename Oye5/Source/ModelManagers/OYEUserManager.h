//
//  OYEUserManager.h
//  Oye5
//
//  Created by Rita Kyauk on 5/5/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const OYEUserNotificationSignedIn;
extern NSString * const OYEUserNotificationSignedOut;

@class OYEUser;

@interface OYEUserManager : NSObject

+ (instancetype)sharedManager;

- (OYEUser *)user;
- (void)setup;

@end

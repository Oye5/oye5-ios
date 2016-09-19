//
//  OYEUserManager+OYE.h
//  Oye5
//
//  Created by Rita Kyauk on 9/18/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEUserManager.h"

@interface OYEUserManager (OYE)

- (void)signUpOyeWithEmail:(NSString *)email username:(NSString *)username password:(NSString *)password completionBlock:(void (^)(NSString *token, NSError *NSError))completionBlock;
- (void)signInOyeWithEmail:(NSString *)email password:(NSString *)password;

@end

//
//  OYELoginViewController.h
//  Oye5
//
//  Created by Rita Kyauk on 3/26/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OYELoginViewControllerDelegate <NSObject>

- (void)didLogInWithFacebookAccount;

@end

@interface OYELoginViewController : UIViewController

- (void)setDelegate:(id<OYELoginViewControllerDelegate>)delegate;

@end

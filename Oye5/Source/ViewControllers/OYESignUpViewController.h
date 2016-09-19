//
//  OYESignUpViewController.h
//  Oye5
//
//  Created by Rita Kyauk on 9/18/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OYESignUpViewControllerDelegate <NSObject>

- (void)cancelSignUp;

@end

@interface OYESignUpViewController : UIViewController

- (void)setDelegate:(id<OYESignUpViewControllerDelegate>)delegate;

@end

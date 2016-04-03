//
//  OYELoggedInViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 3/26/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import FBSDKCoreKit;
@import FBSDKLoginKit;

#import "OYELoggedInViewController.h"
#import "OYELoginViewController.h"

@interface OYELoggedInViewController () <FBSDKLoginButtonDelegate, OYELoginViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *facebookButtonContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *facebookButtonContainerWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *facebookButtonContainerHeightConstraint;

@property (strong, nonatomic) OYELoginViewController *loginViewController;

@end

@implementation OYELoggedInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupFacebookButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupLoginViewController];
}

#pragma mark - Override getters

- (OYELoginViewController *)loginViewController {
    if (!_loginViewController) {
        _loginViewController = [OYELoginViewController new];
        _loginViewController.delegate = self;
    }
    
    return _loginViewController;
}

#pragma mark - Private

- (void)setupFacebookButton {
    FBSDKLoginButton *facebookButton = [FBSDKLoginButton new];
    facebookButton.delegate = self;
    facebookButton.origin = CGPointZero;
    
    self.facebookButtonContainerWidthConstraint.constant = facebookButton.width;
    self.facebookButtonContainerHeightConstraint.constant = facebookButton.height;
    
    [self.facebookButtonContainer addSubview:facebookButton];
    
    self.facebookButtonContainer.backgroundColor = [UIColor yellowColor];
}

- (void)setupLoginViewController {
    if (![FBSDKAccessToken currentAccessToken]) {
        if (![self.navigationController.viewControllers containsObject:self.loginViewController]) {
            self.loginViewController.navigationItem.hidesBackButton = YES;
            [self.navigationController pushViewController:self.loginViewController animated:NO];
        }
    }
    else if ([self.navigationController.viewControllers containsObject:self.loginViewController]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

#pragma mark - FBSDKLoginButtonDelegate

- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error {
    [self setupLoginViewController];
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    [self setupLoginViewController];
}

#pragma mark - OYELoginViewControllerDelegate

- (void)didLogInWithFacebookAccount {
    [self setupLoginViewController];
}

@end

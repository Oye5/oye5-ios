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
#import "OYELoggedOutViewController.h"
#import "OYEUserManager.h"
#import "OYEUser.h"
#import "OYEGoogleSignOutButton.h"

@interface OYELoggedInViewController () <FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet UIView *logOutButtonContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logOutButtonContainerWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logOutButtonContainerHeightConstraint;

@property (strong, nonatomic) OYELoggedOutViewController *loginViewController;
@property (strong, nonatomic) OYEGoogleSignOutButton *googleButton;

@end

@implementation OYELoggedInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLoginViewController];
    [self setupLogOutButton];
    [self setupNotifications];
}


#pragma mark - Override getters

- (OYELoggedOutViewController *)loginViewController {
    if (!_loginViewController) {
        _loginViewController = [OYELoggedOutViewController new];
    }
    
    return _loginViewController;
}

#pragma mark - Private

- (void)setupLogOutButton {
    switch ([OYEUserManager sharedInstance].user.type) {
        case OYEUserTypeFacebook:
            [self setupFacebookButton];
            break;
            
        case OYEUserTypeGoogle:
            [self setupGoogleButton];
            break;
            
        default:
            DDLogWarn(@"Unable to setup log out button");
    }
}

- (void)setupFacebookButton {
    FBSDKLoginButton *facebookButton = [FBSDKLoginButton new];
    facebookButton.delegate = self;
    
    [self addButton:facebookButton];
}

- (void)setupGoogleButton {
    OYEGoogleSignOutButton *googleButton = [OYEGoogleSignOutButton button];
    
    self.googleButton = googleButton;
    
    [self addButton:googleButton];
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userSignedIn:) name:OYEUserNotificationSignedIn object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userSignedOut:) name:OYEUserNotificationSignedOut object:nil];
}

- (void)addButton:(UIButton *)button {
    // Set container size to button size
    self.logOutButtonContainerWidthConstraint.constant = button.width;
    self.logOutButtonContainerHeightConstraint.constant = button.height;

    // Add button to container
    button.origin = CGPointZero;
    button.size = self.logOutButtonContainer.size;
    button.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.logOutButtonContainer.subviews.lastObject removeFromSuperview];
    [self.logOutButtonContainer addSubview:button];
}

- (void)setupLoginViewController {
    if (![OYEUserManager sharedInstance].user) {
        if (![self.navigationController.viewControllers containsObject:self.loginViewController]) {
            self.loginViewController.navigationItem.hidesBackButton = YES;
            [self.navigationController pushViewController:self.loginViewController animated:NO];
        }
    } else if ([self.navigationController.viewControllers containsObject:self.loginViewController]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

#pragma mark - FBSDKLoginButtonDelegate

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    DDLogDebug(@"*");
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    DDLogDebug(@"*");
}

#pragma mark - Notifications

- (void)userSignedIn:(NSNotification *)notification {
    [self setupLoginViewController];
    [self setupLogOutButton];
}

- (void)userSignedOut:(NSNotification *)notification {
    [self setupLoginViewController];
}

@end

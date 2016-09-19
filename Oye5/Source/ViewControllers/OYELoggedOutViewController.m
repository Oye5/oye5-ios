//
//  OYELoggedOutViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 3/26/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import FBSDKCoreKit;
@import FBSDKLoginKit;

#import <GoogleSignIn/GoogleSignIn.h>

#import "OYELoggedOutViewController.h"
#import "OYESignUpViewController.h"
#import "OYEUser.h"
#import "UIButton+Extensions.h"

@interface OYELoggedOutViewController () <FBSDKLoginButtonDelegate, GIDSignInUIDelegate, OYESignUpViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *facebookButtonContainer;
@property (weak, nonatomic) IBOutlet UIView *googleButtonContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *googleButtonContainerHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *googleButtonContainerBottomSpaceConstraint;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@end

@implementation OYELoggedOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupFacebookButton];
    [self setupGoogleButton];
    [self setupSignInButton];
    [self setupSignUpButton];
    [self setupBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupFacebookButton {
    FBSDKLoginButton *facebookButton = [FBSDKLoginButton new];
    facebookButton.delegate = self;
    facebookButton.origin = CGPointZero;
    facebookButton.size = self.facebookButtonContainer.size;
    facebookButton.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.facebookButtonContainer addSubview:facebookButton];
    
    self.facebookButtonContainer.backgroundColor = [UIColor clearColor];
}

- (void)setupGoogleButton {
    
    // Hide Google button since we will not support Google login for now
    self.googleButtonContainer.hidden = YES;
    self.googleButtonContainerHeightConstraint.constant = 0;
    self.googleButtonContainerBottomSpaceConstraint.constant = 0;
    return;
    
    [GIDSignIn sharedInstance].uiDelegate = self;

    GIDSignInButton *googleButton = [GIDSignInButton new];
    googleButton.origin = CGPointZero;
    googleButton.size = self.googleButtonContainer.size;
    googleButton.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    googleButton.colorScheme = kGIDSignInButtonColorSchemeDark;
    
    [self.googleButtonContainer addSubview:googleButton];
    
    self.googleButtonContainer.backgroundColor = [UIColor clearColor];
}

- (void)setupSignInButton {
    [self.signInButton setupAsPrimaryButton];
}

- (void)setupSignUpButton {
    [self.signUpButton setupAsSecondaryButton];
}

- (void)setupBackground {
    self.view.backgroundColor = [UIColor lightGrayColor];
}

#pragma mark - FBSDKLoginButtonDelegate

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - GIDSignInUIDelegate

// The sign-in flow has finished selecting how to proceed, and the UI should no longer display
// a spinner or other "please wait" element.
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    DDLogDebug(@"*");
}

- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:^{
        ;
    }];
}

- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - IBActions

- (IBAction)signUp:(UIButton *)sender {
    DDLogDebug(@"*");
    
    OYESignUpViewController *viewController = [OYESignUpViewController new];
    viewController.delegate = self;
    
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)signIn:(UIButton *)sender {
    DDLogDebug(@"*");
}

#pragma mark - OYESignUpViewControllerDelegate

- (void)cancelSignUp {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

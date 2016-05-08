//
//  OYELoginViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 3/26/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import FBSDKCoreKit;
@import FBSDKLoginKit;

#import <GoogleSignIn/GoogleSignIn.h>

#import "OYELoginViewController.h"
#import "OYEUser.h"

@interface OYELoginViewController () <FBSDKLoginButtonDelegate, GIDSignInUIDelegate>

@property (weak, nonatomic) IBOutlet UIView *facebookButtonContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *facebookButtonContainerWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *facebookButtonContainerHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *googleButtonContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *googleButtonContainerWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *googleButtonContainerHeightConstraint;

@end

@implementation OYELoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupFacebookButton];
    [self setupGoogleButton];
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
    
    self.facebookButtonContainerWidthConstraint.constant = facebookButton.width;
    self.facebookButtonContainerHeightConstraint.constant = facebookButton.height;
    
    [self.facebookButtonContainer addSubview:facebookButton];
    
    self.facebookButtonContainer.backgroundColor = [UIColor clearColor];
}

- (void)setupGoogleButton {
    [GIDSignIn sharedInstance].uiDelegate = self;

    GIDSignInButton *googleButton = [GIDSignInButton new];
    googleButton.origin = CGPointZero;
//    googleButton.colorScheme = kGIDSignInButtonColorSchemeDark;
    
    self.googleButtonContainerWidthConstraint.constant = googleButton.width;
    self.googleButtonContainerHeightConstraint.constant = googleButton.height;
    
    [self.googleButtonContainer addSubview:googleButton];
    
    self.googleButtonContainer.backgroundColor = [UIColor clearColor];
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

@end

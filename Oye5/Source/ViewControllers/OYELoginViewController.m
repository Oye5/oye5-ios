//
//  OYELoginViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 3/26/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import FBSDKCoreKit;
@import FBSDKLoginKit;

#import "OYELoginViewController.h"

@interface OYELoginViewController () <FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet UIView *facebookButtonContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *facebookButtonContainerWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *facebookButtonContainerHeightConstraint;
@property (weak, nonatomic) id<OYELoginViewControllerDelegate>delegate;

@end

@implementation OYELoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupFacebookButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([FBSDKAccessToken currentAccessToken]
        && [self.delegate respondsToSelector:@selector(didLogInWithFacebookAccount)]) {
        [self.delegate didLogInWithFacebookAccount];
    }
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

@end

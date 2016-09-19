//
//  OYESignUpViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 9/18/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYESignUpViewController.h"
#import "UIButton+Extensions.h"
#import "OYEUserManager+OYE.h"

@interface OYESignUpViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@property (weak, nonatomic) id<OYESignUpViewControllerDelegate> delegate;

@end

@implementation OYESignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor oyeMediumBackgroundColor];
    
    [self setupSignUpButton];
}

- (void)setupSignUpButton {
    [self.signUpButton setupAsPrimaryButton];
    self.signUpButton.enabled = NO;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]].location != NSNotFound) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:NSLocalizedString(@"'%@' contains invalid characters", nil), string] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    self.signUpButton.enabled = (self.emailTextField.text && self.usernameTextField.text && self.passwordTextField.text);
    
    return YES;
}

#pragma mark - IBActions

- (IBAction)cancel:(UIButton *)sender {
    DDLogDebug(@"*");
    [self.delegate cancelSignUp];
}

- (IBAction)signUp:(UIButton *)sender {
    [[OYEUserManager sharedInstance] signUpOyeWithEmail:self.emailTextField.text username:self.usernameTextField.text password:self.passwordTextField.text completionBlock:^(NSString *token, NSError *error) {
        
    }];
}

@end

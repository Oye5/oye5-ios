//
//  OYEProfileViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "OYEProfileViewController.h"
#import "OYELoginViewController.h"

#import "UIColor+Extensions.h"
#import "UIFont+Extensions.h"

static NSString * const cellReuseIdentifier = @"cell";

@interface OYEProfileViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate, FBSDKLoginButtonDelegate, OYELoginViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *facebookButtonContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *facebookButtonContainerWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *facebookButtonContainerHeightConstraint;

@property (strong, nonatomic) OYELoginViewController *loginViewController;

@end

@implementation OYEProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self setupImageView];
    [self setupImageButton];
    [self setupNameLabel];
    [self setupTableView];
    [self setupFacebookButton];
 }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupLoginViewController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupLoginViewController) name:FBSDKAccessTokenDidChangeNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)setupImageView {
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.backgroundColor = [UIColor oyeBackgroundColor];
    self.imageView.layer.cornerRadius = self.imageView.width / 2;
    self.imageView.layer.masksToBounds = YES;
}

- (void)setupImageButton {
}

- (void)setupNameLabel {
    self.nameLabel.font = [UIFont oyeFontOfSize:16];
    self.nameLabel.textColor = [UIColor oyeDarkTextColor];
}

- (void)setupTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseIdentifier];
}

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
            [self.navigationController pushViewController:self.loginViewController animated:NO];
        }
    }
    else if ([self.navigationController.viewControllers containsObject:self.loginViewController]) {
            [self.navigationController popToRootViewControllerAnimated:NO];
    }
 }

- (void)deleteImage {
    self.imageView.image = nil;
}

- (void)presentImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *controller = [UIImagePickerController new];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    
    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        && (sourceType != UIImagePickerControllerSourceTypeCamera)) {
        controller.modalPresentationStyle = UIModalPresentationPopover;
        controller.popoverPresentationController.sourceView = self.imageView;
        controller.popoverPresentationController.sourceRect = CGRectMake(self.imageView.width / 2.0, self.imageView.height, 0, 0);
    }
    
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - IBActions

- (IBAction)changeProfilePhoto:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof(self) weakSelf = self;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Take Photo", @"Profile - Photo Action Sheet") style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * action) {
                                                                    [weakSelf presentImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
                                                                }];
        [alert addAction:takePhotoAction];
    }

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIAlertAction *choosePhotoAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Choose Photo", @"Profile - Photo Action Sheet") style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                [weakSelf presentImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                                                            }];
        [alert addAction:choosePhotoAction];
    }
    
    if (self.imageView.image) {
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Delete", @"Profile - Photo Action Sheet") style:UIAlertActionStyleDestructive
                                                                  handler:^(UIAlertAction * action) {
                                                                      weakSelf.imageView.image = nil;
                                                                  }];
        [alert addAction:deleteAction];
    }
    
    if (alert.actions.count) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Profile - Photo Action Sheet") style:UIAlertActionStyleCancel
                                                                  handler:^(UIAlertAction * action) {}];
        [alert addAction:cancelAction];

        UIButton *button = sender;
        alert.popoverPresentationController.sourceView = button;
        alert.popoverPresentationController.sourceRect = CGRectMake(button.width / 2.0, button.height, 0, 0);
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITablieViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Profile %ld", (long)indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

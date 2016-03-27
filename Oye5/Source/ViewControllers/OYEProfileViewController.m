//
//  OYEProfileViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import FBSDKCoreKit;
@import AFNetworking.UIImageView_AFNetworking;

#import "OYEProfileViewController.h"

#import "UIColor+Extensions.h"
#import "UIFont+Extensions.h"

static NSString * const cellReuseIdentifier = @"cell";

@interface OYEProfileViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OYEProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self setupImageView];
    [self setupImageButton];
    [self setupNameLabel];
    [self setupTableView];
    [self setupFacebook];
    [self setupNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)setupFacebook {
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    [self setupUIWithFacebookProfile];
}

- (void)setupUIWithFacebookProfile {
    //    if ([FBSDKAccessToken currentAccessToken]) {
    //        [self setupProfilePictureFromFacebookWithUserID:[FBSDKAccessToken currentAccessToken].userID];
    //    }
    
    [self resetUI];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        if ([FBSDKProfile currentProfile]) {
            [self setupProfilePictureFromFacebookWithUserID:[FBSDKProfile currentProfile].userID];
            
            self.nameLabel.text = [FBSDKProfile currentProfile].name;
        } else {
            // Fields can be found at:  https://developers.facebook.com/docs/graph-api/reference/user
            NSString *parameterValue = [NSString stringWithFormat:@"id,name,picture.width(%@).height(%@)", @(self.imageView.width), @(self.imageView.height)];

            __weak __typeof(self) weakSelf = self;
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : parameterValue}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    NSString *nameOfLoginUser = [result valueForKey:@"name"];
                    
                    weakSelf.nameLabel.text = nameOfLoginUser;
                    
                    NSString *imageStringOfLoginUser = [[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
                    NSURL *url = [[NSURL alloc] initWithString:imageStringOfLoginUser];
                    
                    [weakSelf.imageView setImageWithURL:url placeholderImage: nil];
                 }
            }];
        }
    }
}

- (void)setupProfilePictureFromFacebookWithUserID:(NSString *)userID {
    FBSDKProfilePictureView *fbPictureView = [FBSDKProfilePictureView new];
    fbPictureView.pictureMode = FBSDKProfilePictureModeSquare;
    fbPictureView.profileID = userID;
    fbPictureView.frame = self.imageView.bounds;
    
    [fbPictureView setNeedsImageUpdate];
    
    [self.imageView addSubview:fbPictureView];
    
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(profileDidChangeNotification:) name:FBSDKProfileDidChangeNotification object:nil];
}

- (void)resetUI {
    for (UIView *aSubview in self.imageView.subviews) {
        if ([aSubview isKindOfClass:[FBSDKProfilePictureView class]]) {
            [aSubview removeFromSuperview];
        }
    }
    
    self.imageView.image = nil;
    self.nameLabel.text = nil;
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

#pragma mark - Notifications

- (void)profileDidChangeNotification:(NSNotification *)notification {
    
    [self setupUIWithFacebookProfile];
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

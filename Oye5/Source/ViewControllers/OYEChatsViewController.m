//
//  OYEChatsViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "OYEChatsViewController.h"
#import "OYELoginViewController.h"

static NSString * const OYEChatsCellReuseIdentifier = @"OYEChatsCell";

typedef NS_ENUM(NSUInteger, OYEChatsSectionType) {
    OYEChatsSectionTypeSelling,
    OYEChatsSectionTypeBuying,
    OYEChatsSectionTypeCount
};

@interface OYEChatsViewController () <UITableViewDataSource, UITableViewDelegate, OYELoginViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) OYELoginViewController *loginViewController;

@end

@implementation OYEChatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupLoginViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:OYEChatsCellReuseIdentifier];
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

#pragma mark - Override getters

- (OYELoginViewController *)loginViewController {
    if (!_loginViewController) {
        _loginViewController = [OYELoginViewController new];
        _loginViewController.delegate = self;
    }
    
    return _loginViewController;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return OYEChatsSectionTypeCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case OYEChatsSectionTypeSelling:
            return 1;
        case OYEChatsSectionTypeBuying:
            return 1;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OYEChatsCellReuseIdentifier forIndexPath:indexPath];
    switch (indexPath.section) {
        case OYEChatsSectionTypeSelling:
            cell.textLabel.text = @"Sell cell";
            return cell;
        case OYEChatsSectionTypeBuying:
            cell.textLabel.text = @"Buy cell";
            return cell;
        default:
            return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case OYEChatsSectionTypeSelling:
            return NSLocalizedString(@"Selling", nil);
        case OYEChatsSectionTypeBuying:
            return NSLocalizedString(@"Buying", nil);
        default:
            return nil;
    }
}

#pragma mark - UITableViewDelegate

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

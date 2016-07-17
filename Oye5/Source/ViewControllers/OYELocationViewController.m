//
//  OYELocationViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 7/16/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYELocationViewController.h"

@interface OYELocationViewController ()

@property (nonatomic, weak) IBOutlet UIToolbar *toolbar;
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *titleItem;
@property (nonatomic, weak) IBOutlet UIButton *saveButton;

@property (nonatomic, weak) id<OYELocationViewControllerDelegate> delegate;

@end

@implementation OYELocationViewController

+ (instancetype)viewControllerWithDelegate:(id<OYELocationViewControllerDelegate>)delegate {
    OYELocationViewController *instance = [OYELocationViewController new];
    instance.delegate = delegate;
    
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupToolbar];
}

#pragma mark - Private

- (void)setupToolbar {
    self.toolbar.barTintColor = [UIColor oyePrimaryColor];
    self.toolbar.tintColor = [UIColor oyeLightTextColor];
    
    self.cancelButton.titleLabel.font = [UIFont oyeFontOfSize:15.0];
    [self.cancelButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    [self.cancelButton sizeToFit];
    
    self.titleItem.title = NSLocalizedString(@"Location", nil);
    
    self.saveButton.titleLabel.font = [UIFont oyeFontOfSize:15.0];
    [self.saveButton setTitle:NSLocalizedString(@"Save", nil) forState:UIControlStateNormal];
    [self.saveButton sizeToFit];
}

#pragma mark - IBOutlets

- (IBAction)cancel:(id)sender {
    DDLogDebug(@"*");
    
    [self.delegate didCancelLocationViewController:self];
}

- (IBAction)save:(id)sender {
    DDLogDebug(@"*");
    
    [self.delegate didChangeLocationViewController:self];
}

@end

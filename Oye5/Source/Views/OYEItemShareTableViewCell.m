//
//  OYEItemShareTableViewCell.m
//  Oye5
//
//  Created by Rita Kyauk on 3/26/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import MessageUI;
@import FBSDKShareKit;

#import "OYEItemShareTableViewCell.h"
#import "OYEItem.h"
#import "UIFont+Extensions.h"
#import "UIColor+Extensions.h"

@interface OYEItemShareTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;

@property (weak, nonatomic) id<OYEItemShareTableViewCellDelegate> delegate;
@property (strong, nonatomic) FBSDKShareButton *facebookButton;
@property (strong, nonatomic) OYEItem *item;

@end

@implementation OYEItemShareTableViewCell

+ (CGFloat)cellHeight:(NSDictionary *)data {
    return 88;
}

- (void)awakeFromNib {
    [super awakeFromNib];
 
    [self setupTitleLabel];
    [self setupFacebookButton];
    [self setupMessageButton];
    [self setupEmailButton];
}

- (void)setupTitleLabel {
    self.titleLabel.text = NSLocalizedString(@"SHARE THIS PRODUCT", nil);
    self.titleLabel.font = [UIFont mediumOyeFontOfSize:16];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor oyeMediumTextColor];
}

- (void)setupMessageButton {
    if (![MFMessageComposeViewController canSendText]) {
        self.messageButton.enabled = NO;
    }
}

- (void)setupEmailButton {
    if (![MFMailComposeViewController canSendMail]) {
        self.emailButton.enabled = NO;
    }
}

- (void)setupFacebookButton {
    FBSDKShareLinkContent *content = [FBSDKShareLinkContent new];
#warning Maybe open up app to item?
    content.contentURL = [NSURL URLWithString:@"https://www.facebook.com/FacebookDevelopers"];
    content.contentTitle = self.item.itemTitle;
    content.contentDescription = self.item.itemDescription;
    content.imageURL = [NSURL URLWithString:self.item.images.firstObject];
    
    self.facebookButton = [FBSDKShareButton new];
    self.facebookButton.shareContent = content;
     
    UIBarButtonItem *facebookBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.facebookButton];
    
    NSMutableArray *items = [self.toolBar.items mutableCopy];
    [items insertObject:facebookBarButtonItem atIndex:1];
    self.toolBar.items = items;
}

#pragma mark - IBAction

- (IBAction)didSeleMessageButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectMessageButton)]) {
        [self.delegate didSelectMessageButton];
    }
}

- (IBAction)didSelectEmailButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectEmailButton)]) {
        [self.delegate didSelectEmailButton];
    }
}

@end

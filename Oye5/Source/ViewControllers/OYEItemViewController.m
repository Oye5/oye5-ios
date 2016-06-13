//
//  OYEItemViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 2/28/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import MessageUI;

#import "OYEItemViewController.h"
#import "OYEItem.h"
#import "OYEItemDetailTableViewCell.h"
#import "OYEItemLocationTableViewCell.h"
#import "OYEItemShareTableViewCell.h"

#import "UIColor+Extensions.h"
#import "UIFont+Extensions.h"
#import "UIButton+Extensions.h"

typedef NS_ENUM(NSUInteger, OYEItemTableViewRowType) {
    OYEItemTableViewRowTypeDetail,
    OYEItemTableViewRowTypeLocation,
    OYEItemTableViewRowTypeShare,
    OYEItemTableViewRowTypeReport,
    OYEItemTableViewRowTypeCount
};

static NSString * const OYEItemTableViewCellIdentfierDetail = @"OYEItemDetailTableViewCell";
static NSString * const OYEItemTableViewCellIdentfierLocation = @"OYEItemLocationTableViewCell";
static NSString * const OYEItemTableViewCellIdentfierShare = @"OYEItemShareTableViewCell";
static NSString * const OYEItemTableViewCellIdentfierReport = @"OYEItemReportTableViewCell";

@interface OYEItemViewController () <UITableViewDataSource, UITableViewDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate, OYEItemShareTableViewCellDelegate>

@property (strong, nonatomic) OYEItem *item;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *questionButton;
@property (weak, nonatomic) IBOutlet UIButton *offerButton;

@end

@implementation OYEItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)setupUI {
    self.automaticallyAdjustsScrollViewInsets = NO;

//    [self setupNavigationBar];
    [self setupTableView];
//    [self setupQuestionButton];
//    [self setupOfferButton];
    
    self.questionButton.hidden = YES;
    self.offerButton.hidden = YES;
}

- (void)setupNavigationBar {
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Share", nil) style:UIBarButtonItemStylePlain target:self action:@selector(didSelectShareButton:)];
    self.navigationItem.rightBarButtonItem = shareButton;
}

- (void)setupTableView {
    
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom = self.view.height - self.questionButton.top;

    self.tableView.contentInset = insets;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OYEItemDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:OYEItemTableViewCellIdentfierDetail];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OYEItemLocationTableViewCell class]) bundle:nil] forCellReuseIdentifier:OYEItemTableViewCellIdentfierLocation];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OYEItemShareTableViewCell class]) bundle:nil] forCellReuseIdentifier:OYEItemTableViewCellIdentfierShare];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:OYEItemTableViewCellIdentfierReport];
}

- (void)setupQuestionButton {
    [self.questionButton setTitle:NSLocalizedString(@"Ask a Question", nil) forState:UIControlStateNormal];
    [self.questionButton setupAsSecondaryButton];
}

- (void)setupOfferButton {
    [self.offerButton setTitle:NSLocalizedString(@"Make an Offer", nil) forState:UIControlStateNormal];
    [self.offerButton setupAsPrimaryButton];
}

- (UITableViewCell *)detailCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    OYEItemDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OYEItemTableViewCellIdentfierDetail forIndexPath:indexPath];
    
    cell.item = self.item;
    
    return cell;
}

- (UITableViewCell *)locationCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    OYEItemLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OYEItemTableViewCellIdentfierLocation forIndexPath:indexPath];
    
    cell.item = self.item;
    
    return cell;
}

- (UITableViewCell *)shareCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OYEItemTableViewCellIdentfierShare forIndexPath:indexPath];
//    
//    cell.textLabel.text = NSLocalizedString(@"SHARE THIS PRODUCT", nil);
//    cell.textLabel.font = [UIFont mediumOyeFontOfSize:16];
//    cell.textLabel.textAlignment = NSTextAlignmentCenter;
//    cell.textLabel.textColor = [UIColor oyeMediumTextColor];
    
    OYEItemShareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OYEItemTableViewCellIdentfierShare forIndexPath:indexPath];
    cell.delegate = self;
    cell.item = self.item;
    
    return cell;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return OYEItemTableViewRowTypeCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case OYEItemTableViewRowTypeDetail:
            return [self detailCellInTableView:tableView atIndexPath:indexPath];
        case OYEItemTableViewRowTypeLocation:
            return [self locationCellInTableView:tableView atIndexPath:indexPath];
        case OYEItemTableViewRowTypeShare:
            return [self shareCellInTableView:tableView atIndexPath:indexPath];
        case OYEItemTableViewRowTypeReport:
            return [tableView dequeueReusableCellWithIdentifier:OYEItemTableViewCellIdentfierReport forIndexPath:indexPath];
    }
    
    // It shouldn't reach this
    DDLogError(@"Undefined row");
    
    return [UITableViewCell new];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *heightInformation = @{OYETableViewCellHeightItemKey:self.item, OYETableViewCellHeightWidthKey:@(self.tableView.width)};
    
    switch (indexPath.row) {
        case OYEItemTableViewRowTypeDetail:
            return [OYEItemDetailTableViewCell cellHeight:heightInformation];
        case OYEItemTableViewRowTypeLocation:
            return [OYEItemLocationTableViewCell cellHeight:heightInformation];
        case OYEItemTableViewRowTypeShare:
            return [OYEItemShareTableViewCell cellHeight:heightInformation];
        default:
            return 44;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == OYEItemTableViewRowTypeShare) {
//        // Use buttons for now instead of UIActivityViewController
//        return indexPath;
//    }
    
    return nil;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    switch (indexPath.row) {
//        case OYEItemTableViewRowTypeShare:
//            [self shareItem];
//            break;
//            
//        default:
//            break;
//    }
//}

#pragma mark - Action

- (IBAction)didSelectQuestionButton:(id)sender {
}

- (IBAction)didSelectOfferButton:(id)sender {
}

- (void)didSelectShareButton:(id)sender {
    UIActivityViewController *viewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.item] applicationActivities:nil];
    
    viewController.excludedActivityTypes = @[UIActivityTypePostToTwitter,
                                             UIActivityTypePostToWeibo,
                                             UIActivityTypeAssignToContact,
                                             UIActivityTypeSaveToCameraRoll,
                                             UIActivityTypeAddToReadingList,
                                             UIActivityTypePostToFlickr,
                                             UIActivityTypePostToVimeo,
                                             UIActivityTypePostToTencentWeibo,
                                             UIActivityTypeAirDrop];
    
    viewController.completionWithItemsHandler = ^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {
        if (completed) {
            if ([activityType isEqualToString:UIActivityTypeMessage]) {
                
            } else if ([activityType isEqualToString:UIActivityTypeMail]) {
                
            } else if ([activityType isEqualToString:UIActivityTypePostToFacebook]) {
                
            }
        }
    };
    
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - OYEItemShareTableViewCellDelegate

- (void)didSelectMessageButton {
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *viewController = [MFMessageComposeViewController new];
        viewController.messageComposeDelegate = self;
        
        NSString *message = [NSString stringWithFormat:@"%@\n\n%@", NSLocalizedString(@"Check out this item on OYE5!", nil), self.item.itemTitle];
        viewController.body = message;
        
        [self presentViewController:viewController animated:YES completion:nil];
    } else {
        DDLogError(@"Message services are not available.");
    }
}

- (void)didSelectEmailButton {
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *viewController = [MFMailComposeViewController new];
        viewController.mailComposeDelegate = self;
        
        // Configure the fields of the interface.
        [viewController setSubject:self.item.itemTitle];
        NSString *message = [NSString stringWithFormat:@"%@\n\n%@", NSLocalizedString(@"Check out this item on OYE5!", nil), self.item.itemTitle];
        [viewController setMessageBody:message isHTML:NO];
        
        // Present the view controller modally.
        [self presentViewController:viewController animated:YES completion:nil];
        
    } else {
        DDLogError(@"Mail services are not available.");
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
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

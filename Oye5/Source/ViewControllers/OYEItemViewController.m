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
#import "OYEItemDetailsCollectionViewCell.h"
#import "OYEItemLocationCollectionViewCell.h"
#import "OYEItemCollectionViewCell.h"
#import "OYETitleCollectionReusableView.h"
#import "OYEItemManager.h"
//#import "OYEItemShareTableViewCell.h"
#import "UIColor+Extensions.h"
#import "UIFont+Extensions.h"
#import "UIButton+Extensions.h"

typedef NS_ENUM(NSUInteger, OYEItemCollectionViewSectionType) {
    OYEItemCollectionViewSectionTypeItemDetails,
    OYEItemCollectionViewSectionTypeSimilarItems,
    OYEItemCollectionViewSectionTypeCount
};

typedef NS_ENUM(NSUInteger, OYEItemCollectionViewDetailsRowType) {
    OYEItemCollectionViewDetailsRowTypeDetail,
    OYEItemCollectionViewDetailsRowTypeLocation,
    OYEItemCollectionViewDetailsRowTypeCount
};

static NSString * const OYEItemCollectionViewCellIdentfierDetail = @"OYEItemDetailsCollectionViewCell";
static NSString * const OYEItemCollectionViewCellIdentfierLocation = @"OYEItemLocationCollectionViewCell";
static NSString * const OYEItemCollectionViewCellIdentfierSimilarItem = @"OYEItemCollectionViewCell";
static NSString * const OYESectionHeaderReuseIdentifierSimilarItems = @"OYETitleCollectionReusableView";

static CGFloat const OYESectionHeaderHeightSimilarItems = 44.0;

@interface OYEItemViewController () <UICollectionViewDataSource, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate/*, OYEItemShareTableViewCellDelegate*/>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) OYEItem *item;
@property (strong, nonatomic) NSArray<OYEItem *> *similarItems;

@end

@implementation OYEItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
#warning Need to request similar items here
    self.similarItems = [OYEItemManager getItems];
    
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
    [self setupCollectionView];
}

- (void)setupNavigationBar {
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Share", nil) style:UIBarButtonItemStylePlain target:self action:@selector(didSelectShareButton:)];
    self.navigationItem.rightBarButtonItem = shareButton;
}

- (void)setupCollectionView {
    self.collectionView.backgroundColor = [UIColor oyeLightGrayBackgroundColor];
    
    UIEdgeInsets insets = self.collectionView.contentInset;
    insets.bottom = self.tabBarController.tabBar.height;
    self.collectionView.contentInset = insets;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([OYEItemDetailsCollectionViewCell class]) bundle:[NSBundle bundleForClass:[OYEItemDetailsCollectionViewCell class]]] forCellWithReuseIdentifier:OYEItemCollectionViewCellIdentfierDetail];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([OYEItemLocationCollectionViewCell class]) bundle:[NSBundle bundleForClass:[OYEItemLocationCollectionViewCell class]]] forCellWithReuseIdentifier:OYEItemCollectionViewCellIdentfierLocation];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([OYEItemCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:OYEItemCollectionViewCellIdentfierSimilarItem];
    
    [self.collectionView registerClass:[OYETitleCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:OYESectionHeaderReuseIdentifierSimilarItems];
}

- (UICollectionViewCell *)detailCellInCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    OYEItemDetailsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OYEItemCollectionViewCellIdentfierDetail forIndexPath:indexPath];
    cell.item = self.item;
    
    return cell;
}

- (UICollectionViewCell *)locationCellInCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    OYEItemLocationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OYEItemCollectionViewCellIdentfierLocation forIndexPath:indexPath];
    cell.item = self.item;
    
    return cell;
}

- (UICollectionViewCell *)similarItemCellInCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    OYEItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OYEItemCollectionViewCellIdentfierSimilarItem forIndexPath:indexPath];
    cell.item = self.similarItems[indexPath.row];
    CGFloat outerMargin = 10.0;
    CGFloat innerMargin = 5.0;
    if (indexPath.row % 2) {
        [cell setRightMargin:outerMargin];
        [cell setLeftMargin:innerMargin];
    } else {
        [cell setLeftMargin:outerMargin];
        [cell setRightMargin:innerMargin];
    }
    
    return cell;

}

//- (UITableViewCell *)shareCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OYEItemTableViewCellIdentfierShare forIndexPath:indexPath];
//    
//    cell.textLabel.text = NSLocalizedString(@"SHARE THIS PRODUCT", nil);
//    cell.textLabel.font = [UIFont mediumOyeFontOfSize:16];
//    cell.textLabel.textAlignment = NSTextAlignmentCenter;
//    cell.textLabel.textColor = [UIColor oyeMediumTextColor];
//    
//    OYEItemShareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OYEItemTableViewCellIdentfierShare forIndexPath:indexPath];
//    cell.delegate = self;
//    cell.item = self.item;
//    
//    return cell;
//}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return OYEItemCollectionViewSectionTypeCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case OYEItemCollectionViewSectionTypeItemDetails:
            return OYEItemCollectionViewDetailsRowTypeCount;
            
        case OYEItemCollectionViewSectionTypeSimilarItems:
            return self.similarItems.count;
            
        default:
            return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case OYEItemCollectionViewSectionTypeItemDetails:
            switch (indexPath.row) {
                case OYEItemCollectionViewDetailsRowTypeDetail:
                    return [self detailCellInCollectionView:collectionView atIndexPath:indexPath];
                case OYEItemCollectionViewDetailsRowTypeLocation:
                    return [self locationCellInCollectionView:collectionView atIndexPath:indexPath];
            }
            break;
            
        case OYEItemCollectionViewSectionTypeSimilarItems:
            return [self similarItemCellInCollectionView:collectionView atIndexPath:indexPath];
     }
    
    return [UICollectionViewCell new];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == OYEItemCollectionViewSectionTypeSimilarItems) {
        
        OYEItemViewController *viewController = [OYEItemViewController new];
        viewController.item = self.similarItems[indexPath.row];
        
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *heightInformation = @{OYECollectionViewCellHeightItemKey:self.item, OYECollectionViewCellHeightWidthKey:@(self.collectionView.width)};

    switch (indexPath.section) {
        case OYEItemCollectionViewSectionTypeItemDetails:
            switch (indexPath.row) {
                case OYEItemCollectionViewDetailsRowTypeDetail:
                    return CGSizeMake(self.view.width, [OYEItemDetailsCollectionViewCell cellHeight:heightInformation]);
                case OYEItemCollectionViewDetailsRowTypeLocation:
                    return CGSizeMake(self.view.width, [OYEItemLocationCollectionViewCell cellHeight:heightInformation]);
            }
            break;
        case OYEItemCollectionViewSectionTypeSimilarItems:
        {
            UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
            
            CGSize cellSize = CGSizeMake((collectionView.width  - flowLayout.minimumLineSpacing /*- 2 * OYEExploreCollectionViewHorizontalInset*/) / 2, 250);
            
            return cellSize;
        }
    }
    
    return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    switch (section) {
        case OYEItemCollectionViewSectionTypeItemDetails:
            return 0;
        case OYEItemCollectionViewSectionTypeSimilarItems:
        default:
            return 0;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case OYEItemCollectionViewSectionTypeSimilarItems:
            return CGSizeMake(collectionView.width, OYESectionHeaderHeightSimilarItems);
            
        default:
            return CGSizeZero;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        switch (indexPath.section) {
            case OYEItemCollectionViewSectionTypeSimilarItems:
            {
                OYETitleCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:OYESectionHeaderReuseIdentifierSimilarItems forIndexPath:indexPath];
 
                return header;
            }
                
            default:
                return nil;
        }
    }
    return nil;
    
}

#pragma mark - Action

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

//
//  OYEItemDetailTableViewCell.m
//  Oye5
//
//  Created by Rita Kyauk on 3/13/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import AFNetworking.UIImageView_AFNetworking;

#import "OYEItemDetailTableViewCell.h"
#import "OYEItem.h"
#import "OYEItemImageViewController.h"
#import "OYEUser.h"
#import "OYETagCollectionViewCell.h"
#import "UIColor+Extensions.h"
#import "UIFont+Extensions.h"

static NSString * const OYETagsReuseIdentifier = @"OYETagsReuseIdentifier";

@interface OYEItemDetailTableViewCell () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *imagesContainer;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIImageView *sellerImageView;
@property (weak, nonatomic) IBOutlet UILabel *sellerNameLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *sellerHearts;
@property (weak, nonatomic) IBOutlet UILabel *sellerNumberOfReviewsLabel;
@property (weak, nonatomic) IBOutlet UIButton *sellerMessageButton;
@property (weak, nonatomic) IBOutlet UIView *lineSeparatorBelowSellerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *makeAnOfferButton;
@property (weak, nonatomic) IBOutlet UILabel *addedDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *tagsCollectionView;
@property (weak, nonatomic) IBOutlet UIView *lineSeparatorAboveDescription;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (strong, nonatomic) OYEItem *item;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSMutableArray<OYEItemImageViewController *> *imageViewControllers;

@end

@implementation OYEItemDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight:(NSDictionary *)data {
    OYEItem *item = data[OYETableViewCellHeightItemKey];
    CGFloat width = [data[OYETableViewCellHeightWidthKey] floatValue];
    
    CGSize descriptionSize = [item.itemDescription sizeWithAttributes:@{NSFontAttributeName:[self itemDescriptionFont]}];
    CGFloat descriptionBuffer = 16;
    CGFloat descriptionHeight = ceil((descriptionSize.width / width)) * [self itemDescriptionFont].lineHeight + descriptionBuffer;
    
    CGFloat imageHeight = width;
    CGFloat spaceBetweenImageAndDescription = 287.0;
    
    CGFloat height = descriptionHeight + imageHeight + spaceBetweenImageAndDescription;
    
    return height;
}

#pragma mark - Public

- (void)setItem:(OYEItem *)item {
    _item = item;
    
    [self setupWithItem];
}

#pragma mark - Private

+ (UIFont *)itemDescriptionFont {
    return [UIFont oyeFontOfSize:12];
}

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    });
    
    return dateFormatter;
}

- (void)setupUI {
    [self setupImagesContainer];
    [self setupPageControl];
    [self setupSellerUI];
    [self setupTitleLabel];
    [self setupConditionLabel];
    [self setupPriceLabel];
    [self setupMakeAnOfferButton];
    [self setupAddedDateLabel];
    [self setupCategoryLabel];
    [self setupTagsCollectionView];
    [self setupDescriptionTextView];
    
    if (self.item) {
        [self setupWithItem];
    }
}

- (void)setupImagesContainer {
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    self.pageViewController.view.frame = self.imagesContainer.bounds;
    self.pageViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.imagesContainer addSubview:self.pageViewController.view];

    if (self.item) {
        [self.pageViewController setViewControllers:@[self.imageViewControllers.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
}

- (void)setupPageControl {
    self.pageControl.hidesForSinglePage = YES;
}

- (void)setupSellerUI {
    [self setupSellerImageView];
    [self setupSellerNameLabel];
    [self setupSellerNumberOfReviewsLabel];
    [self setupSellerMessageButton];
    [self setuplineSeparatorBelowSellerView];
}

- (void)setupSellerImageView {
    self.sellerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.sellerImageView.layer.cornerRadius = self.sellerImageView.width / 2.0;
    self.sellerImageView.layer.masksToBounds = YES;
    self.sellerImageView.backgroundColor = [UIColor oyeLightGrayBackgroundColor];
}

- (void)setupSellerNameLabel {
    self.sellerNameLabel.font = [UIFont mediumOyeFontOfSize:12];
    self.sellerNameLabel.textColor = [UIColor oyeDarkTextColor];
}

- (void)setupSellerNumberOfReviewsLabel {
    self.sellerNumberOfReviewsLabel.font = [UIFont oyeFontOfSize:12];
    self.sellerNumberOfReviewsLabel.textColor = [UIColor oyeMediumTextColor];
}

- (void)setupSellerMessageButton {
    [self.sellerMessageButton setTitle:NSLocalizedString(@"Message", nil) forState:UIControlStateNormal];
    self.sellerMessageButton.titleLabel.font = [UIFont mediumOyeFontOfSize:12];
    [self.sellerMessageButton setTitleColor:[UIColor oyeMediumTextColor] forState:UIControlStateNormal];
    self.sellerMessageButton.backgroundColor = [UIColor oyeLightGrayBackgroundColor];
    self.sellerMessageButton.layer.cornerRadius = 2.0;
    self.sellerMessageButton.layer.masksToBounds = YES;
}

- (void)setuplineSeparatorBelowSellerView {
    self.lineSeparatorBelowSellerView.backgroundColor = [UIColor oyeLineSeparatorColor];
}

- (void)setupTitleLabel {
    self.titleLabel.font = [UIFont boldOyeFontOfSize:13];
    self.titleLabel.textColor = [UIColor oyeDarkTextColor];
}

- (void)setupConditionLabel {
    self.conditionLabel.font = [UIFont mediumOyeFontOfSize:12];
    self.conditionLabel.textColor = [UIColor oyeMediumTextColor];
}

- (void)setupPriceLabel {
    self.priceLabel.font = [UIFont boldOyeFontOfSize:15];
    self.priceLabel.textColor = [UIColor oyeDarkTextColor];
}

- (void)setupMakeAnOfferButton {
    self.makeAnOfferButton.titleLabel.font = [UIFont mediumOyeFontOfSize:12];
    [self.makeAnOfferButton setTitleColor:[UIColor oyeLightTextColor] forState:UIControlStateNormal];
    self.makeAnOfferButton.backgroundColor = [UIColor oyePrimaryColor];
}

- (void)setupAddedDateLabel {
    self.addedDateLabel.font = [UIFont mediumOyeFontOfSize:12];
    self.addedDateLabel.textColor = [UIColor oyeMediumTextColor];
}

- (void)setupCategoryLabel {
    
}

- (void)setupTagsCollectionView {
    [self.tagsCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([OYETagCollectionViewCell class]) bundle:[NSBundle bundleForClass:[OYETagCollectionViewCell class]]] forCellWithReuseIdentifier:OYETagsReuseIdentifier];
    
    self.tagsCollectionView.backgroundColor = [UIColor clearColor];
    self.tagsCollectionView.scrollEnabled = NO;
}

- (void)setupLineSeparatorAboveDescription {
    self.lineSeparatorAboveDescription.backgroundColor = [UIColor oyeLineSeparatorColor];
}

- (void)setupDescriptionTextView {
    [self setupLineSeparatorAboveDescription];
    
    self.descriptionTextView.editable = NO;
    self.descriptionTextView.scrollEnabled = YES;
    self.descriptionTextView.font = [[self class] itemDescriptionFont];
    self.descriptionTextView.textColor = [UIColor oyeDarkTextColor];
}

- (void)setupWithItem {
    self.imageViewControllers = [NSMutableArray array];
    for (NSString *anImageURL in self.item.images) {
        OYEItemImageViewController *viewController = [OYEItemImageViewController new];
        viewController.imageURL = anImageURL;
        
        [self.imageViewControllers addObject:viewController];
    }
    
    if (self.pageViewController) {
        [self.pageViewController setViewControllers:@[self.imageViewControllers.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    
    self.pageControl.numberOfPages = self.item.images.count;
    self.pageControl.currentPage = 0;
    
    [self.sellerImageView setImageWithURL:self.item.seller.imageURL placeholderImage:nil];
    self.sellerNameLabel.text = self.item.seller.name;
    self.sellerNumberOfReviewsLabel.text = [NSString stringWithFormat:@"(%ld)", self.item.seller.numberOfReviews];

    self.titleLabel.text = self.item.itemTitle;
    self.conditionLabel.text = [NSString stringWithFormat:@"Condition:  %@", self.item.condition];
    self.priceLabel.text = [self.item priceString];
    
    self.addedDateLabel.text = [NSString stringWithFormat:@"Added: %@", [[[self class] dateFormatter] stringFromDate:self.item.addedDate]];
    
    NSMutableAttributedString *categoryString = [[NSMutableAttributedString alloc] initWithString:@"Category: "
                                                                        attributes:@{NSFontAttributeName:[UIFont mediumOyeFontOfSize:12],
                                                                                     NSForegroundColorAttributeName:[UIColor oyeMediumTextColor]}];
    NSAttributedString *itemCategory = [[NSAttributedString alloc] initWithString:self.item.category
                                                                       attributes:@{NSFontAttributeName:[UIFont mediumOyeFontOfSize:12],
                                                                                                              NSForegroundColorAttributeName:[UIColor oyeDarkTextColor]}];
    [categoryString appendAttributedString:itemCategory];
    self.categoryLabel.attributedText = categoryString;
    
    [self.tagsCollectionView reloadData];
    
    self.descriptionTextView.text = self.item.itemDescription;
}

#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.imageViewControllers indexOfObject:(OYEItemImageViewController *)viewController] - 1;
    
    
    if (!viewController) {
        return self.imageViewControllers.firstObject;
    }
    
    if (index < 0) {
        return nil;
    }
    
    return self.imageViewControllers[index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    if (!viewController) {
        return self.imageViewControllers.firstObject;
    }
    
    NSInteger index = [self.imageViewControllers indexOfObject:(OYEItemImageViewController *)viewController] + 1;
    
    if (index >= self.imageViewControllers.count) {
        return nil;
    }
    
    return self.imageViewControllers[index];
}

//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
//    return self.item.images.count;
//}
//
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
//    OYEItemImageViewController *currentViewController = pageViewController.viewControllers.firstObject;
//    return [self.imageViewControllers indexOfObject:currentViewController];
//}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    if (finished) {
        OYEItemImageViewController *currentViewController = pageViewController.viewControllers.firstObject;
        self.pageControl.currentPage = [self.imageViewControllers indexOfObject:currentViewController];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.item.tags.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OYETagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OYETagsReuseIdentifier forIndexPath:indexPath];
    cell.nameLabel.text = self.item.tags[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [self.item.tags[indexPath.row] sizeWithAttributes:@{NSFontAttributeName:[OYETagCollectionViewCell font]}];
    CGFloat buffer = 32;

    return CGSizeMake(size.width + buffer, 24);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}

#pragma mark - IBAction

- (IBAction)messageSeller:(id)sender {
    DDLogDebug(@"*");
}

- (IBAction)makeAnOffer:(id)sender {
    DDLogDebug(@"*");
}

@end

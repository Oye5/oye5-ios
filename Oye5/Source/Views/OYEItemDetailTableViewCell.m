//
//  OYEItemDetailTableViewCell.m
//  Oye5
//
//  Created by Rita Kyauk on 3/13/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEItemDetailTableViewCell.h"
#import "OYEItem.h"
#import "OYEItemImageViewController.h"

#import "UIColor+Extensions.h"
#import "UIFont+Extensions.h"

@interface OYEItemDetailTableViewCell () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *imagesContainer;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
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
    
    CGFloat height = width + descriptionHeight + 45;
    
    return height;
}

#pragma mark - Public

- (void)setItem:(OYEItem *)item {
    _item = item;
    
    [self setupWithItem];
}

#pragma mark - Private

+ (UIFont *)itemDescriptionFont {
    return [UIFont oyeFontOfSize:14];
}

- (void)setupUI {
    [self setupImagesContainer];
    [self setupPageControl];
    [self setupPriceLabel];
    [self setupTitleLabel];
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

- (void)setupPriceLabel {
    self.priceLabel.font = [UIFont boldOyeFontOfSize:16];
    self.priceLabel.textColor = [UIColor oyeLightTextColor];
}

- (void)setupTitleLabel {
    self.titleLabel.font = [UIFont oyeFontOfSize:12];
    self.titleLabel.textColor = [UIColor oyeDarkTextColor];
}

- (void)setupDescriptionTextView {
    self.descriptionTextView.editable = NO;
    self.descriptionTextView.scrollEnabled = YES;
    self.descriptionTextView.font = [[self class] itemDescriptionFont];
    self.descriptionTextView.textColor = [UIColor oyeMediumTextColor];
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

    self.priceLabel.text = [self.item priceString];
    self.titleLabel.text = self.item.itemTitle;
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

@end

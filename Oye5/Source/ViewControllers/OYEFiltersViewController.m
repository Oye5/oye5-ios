//
//  OYEFiltersViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 6/25/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEFiltersViewController.h"
#import "UIButton+Extensions.h"

@interface OYEFiltersViewController ()

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *titleItem;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *filtersView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filtersViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *distanceView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIView *distanceSeparator;
@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;

@property (weak, nonatomic) IBOutlet UIView *sortView;
@property (weak, nonatomic) IBOutlet UILabel *sortLabel;
@property (weak, nonatomic) IBOutlet UIView *sortSeparator;
@property (weak, nonatomic) IBOutlet UIButton *sortByNewestButton;
@property (weak, nonatomic) IBOutlet UIButton *sortByPriceLowToHighButton;
@property (weak, nonatomic) IBOutlet UIButton *sortByPriceHighToLowButton;

@property (weak, nonatomic) IBOutlet UIView *categoriesView;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;
@property (weak, nonatomic) IBOutlet UIView *categoriesSeparator;
@property (weak, nonatomic) IBOutlet UIButton *categoryElectronicsButton;
@property (weak, nonatomic) IBOutlet UIButton *categoryFashionAndAcessoriesButton;
@property (weak, nonatomic) IBOutlet UIButton *categoryHomeAndGardenButton;
@property (weak, nonatomic) IBOutlet UIButton *categoryBooksMoviesAndMusicButton;
@property (weak, nonatomic) IBOutlet UIButton *categorySportsAndLeisureButton;
@property (weak, nonatomic) IBOutlet UIButton *categoryCarsAndMotorsButton;
@property (weak, nonatomic) IBOutlet UIButton *categoryBabyAndChildButton;
@property (weak, nonatomic) IBOutlet UIButton *categoryOtherButton;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (nonatomic, weak) id<OYEFiltersViewControllerDelegate> delegate;

@end

@implementation OYEFiltersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor oyeDarkBackgroundColor];
    
    [self setupToolbar];
    [self setupFiltersView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Public

+ (instancetype)viewControllerWithDelegate:(id<OYEFiltersViewControllerDelegate>)delegate {
    OYEFiltersViewController *instance = [OYEFiltersViewController new];
    instance.delegate = delegate;
    
    return instance;
}

#pragma mark - Private

- (void)setupToolbar {
    self.toolbar.barTintColor = [UIColor oyeDarkBackgroundColor];
    self.toolbar.tintColor = [UIColor oyeLightTextColor];
    
    self.cancelButton.titleLabel.font = [UIFont oyeFontOfSize:15.0];
    [self.cancelButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    [self.cancelButton sizeToFit];
    
    self.titleItem.title = NSLocalizedString(@"Filters", nil);

    self.resetButton.titleLabel.font = [UIFont oyeFontOfSize:15.0];
    [self.resetButton setTitle:NSLocalizedString(@"Reset", nil) forState:UIControlStateNormal];
    [self.resetButton sizeToFit];
}

- (void)setupFiltersView {
    self.filtersView.origin = CGPointZero;
    self.filtersView.backgroundColor = [UIColor clearColor];
    
    [self setupDistanceSection];
    [self setupSortSection];
    [self setupCategoriesSection];
    [self setupSaveButton];

    [self addFiltersViewToScrollView];
}

- (void)setupDistanceSection {
    [self.distanceView setupCornerRadius];
    [self setupSection:NSLocalizedString(@"Distance", nil) label:self.distanceLabel separator:self.distanceSeparator];
    
    self.distanceSlider.tintColor = [UIColor oyeDarkBackgroundColor];
}

- (void)setupSortSection {
    [self.sortView setupCornerRadius];
    [self setupSection:NSLocalizedString(@"Sort By:", nil) label:self.sortLabel separator:self.sortSeparator];
    
    [self.sortByNewestButton setTitle:NSLocalizedString(@"Newest first", nil) forState:UIControlStateNormal];
    [self.sortByPriceLowToHighButton setTitle:NSLocalizedString(@"Price low to high", nil) forState:UIControlStateNormal];
    [self.sortByPriceHighToLowButton setTitle:NSLocalizedString(@"Price high to low", nil) forState:UIControlStateNormal];
    
    [self checkSortFilter];
}

- (void)setupCategoriesSection {
    [self.categoriesView setupCornerRadius];
    [self setupSection:NSLocalizedString(@"Categories:", nil) label:self.categoriesLabel separator:self.categoriesSeparator];
    
    // Setup titles
    [self.categoryElectronicsButton setTitle:NSLocalizedString(@"Electronics", nil) forState:UIControlStateNormal];
    [self.categoryFashionAndAcessoriesButton setTitle:NSLocalizedString(@"Fasion & Accesories", nil) forState:UIControlStateNormal];
    [self.categoryHomeAndGardenButton setTitle:NSLocalizedString(@"Home & Garden", nil) forState:UIControlStateNormal];
    [self.categoryBooksMoviesAndMusicButton setTitle:NSLocalizedString(@"Books, Movies, & Music", nil) forState:UIControlStateNormal];
    [self.categorySportsAndLeisureButton setTitle:NSLocalizedString(@"Sports & Leisure", nil) forState:UIControlStateNormal];
    [self.categoryCarsAndMotorsButton setTitle:NSLocalizedString(@"Cars & Motors", nil) forState:UIControlStateNormal];
    [self.categoryBabyAndChildButton setTitle:NSLocalizedString(@"Baby & Children", nil) forState:UIControlStateNormal];
    [self.categoryOtherButton setTitle:NSLocalizedString(@"Other", nil) forState:UIControlStateNormal];
    
    // Setup current settings
}

- (void)setupSection:(NSString *)section label:(UILabel *)label separator:(UIView *)separator {
    label.text = section;
    label.textColor = [UIColor oyePrimaryColor];
    label.font = [UIFont mediumOyeFontOfSize:15.0];
    
    separator.backgroundColor = [UIColor oyeLineSeparatorColor];
}

- (void)setupSaveButton {
    [self.saveButton setupAsPrimaryButton];

    [self.saveButton setTitle:NSLocalizedString(@"Save Filters", nil) forState:UIControlStateNormal];
}

- (void)addFiltersViewToScrollView {
    
    // Add filters view in scroll view

    // Top
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.filtersView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.scrollView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:0.0];
    // Leading
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.filtersView
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.scrollView
                                                                      attribute:NSLayoutAttributeLeading
                                                                     multiplier:1.0
                                                                       constant:0.0];
    // Trailing
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.filtersView
                                                                         attribute:NSLayoutAttributeTrailing
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.scrollView
                                                                         attribute:NSLayoutAttributeTrailing
                                                                        multiplier:1.0
                                                                          constant:0.0];
    // Width
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.filtersView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.scrollView
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:1.0
                                                                        constant:0.0];
    [self.scrollView addSubview:self.filtersView];
    [self.scrollView addConstraint:topConstraint];
    [self.scrollView addConstraint:leadingConstraint];
    [self.scrollView addConstraint:trailingConstraint];
    [self.scrollView addConstraint:widthConstraint];

    self.scrollView.contentSize = self.filtersView.size;
}

- (void)checkSortFilter {
    if (!self.sortByNewestButton.selected
        && !self.sortByPriceLowToHighButton.selected
        && !self.sortByPriceHighToLowButton.selected) {
        self.sortByNewestButton.selected = YES;
    }
}

#pragma mark - IBOutlets

- (IBAction)cancel:(id)sender {
    DDLogDebug(@"*");
    
    [self.delegate didCancelFiltersViewController:self];
}

- (IBAction)resetFilters:(id)sender {
    DDLogDebug(@"*");
}

- (IBAction)saveFilters:(id)sender {
    DDLogDebug(@"*");

    [self.delegate didSaveFiltersViewController:self];
}

- (IBAction)changeDistanceFilter:(UISlider *)sender {
    DDLogDebug(@"Filter value = %f", sender.value);
}

- (IBAction)sortByNewest:(id)sender {
    DDLogDebug(@"*");
    [self.sortByNewestButton toggleButton];
    if (self.sortByNewestButton.selected) {
        self.sortByPriceLowToHighButton.selected = NO;
        self.sortByPriceHighToLowButton.selected = NO;
    } else {
        [self checkSortFilter];
    }
}

- (IBAction)sortByPriceLowToHigh:(id)sender {
    DDLogDebug(@"*");
    [self.sortByPriceLowToHighButton toggleButton];
    if (self.sortByPriceLowToHighButton.selected) {
        self.sortByNewestButton.selected = NO;
        self.sortByPriceHighToLowButton.selected = NO;
    } else {
        [self checkSortFilter];
    }
}

- (IBAction)sortByPriceHighToLow:(id)sender {
    DDLogDebug(@"*");
    [self.sortByPriceHighToLowButton toggleButton];
    if (self.sortByPriceHighToLowButton.selected) {
        self.sortByNewestButton.selected = NO;
        self.sortByPriceLowToHighButton.selected = NO;
    } else {
        [self checkSortFilter];
    }
}

- (IBAction)filterForElectronics:(id)sender {
    DDLogDebug(@"*");
    [self.categoryElectronicsButton toggleButton];
}

- (IBAction)filterForFashionAndAccessories:(id)sender {
    DDLogDebug(@"*");
    [self.categoryFashionAndAcessoriesButton toggleButton];
}

- (IBAction)filterForHomeAndGarden:(id)sender {
    DDLogDebug(@"*");
    [self.categoryHomeAndGardenButton toggleButton];
}

- (IBAction)filterForBooksMoviesAndMusic:(id)sender {
    DDLogDebug(@"*");
    [self.categoryBooksMoviesAndMusicButton toggleButton];
}

- (IBAction)filterForSportsAndLeisure:(id)sender {
    DDLogDebug(@"*");
    [self.categorySportsAndLeisureButton toggleButton];
}

- (IBAction)filterForCarsAndMotors:(id)sender {
    DDLogDebug(@"*");
    [self.categoryCarsAndMotorsButton toggleButton];
}

- (IBAction)filterForBabyAndChild:(id)sender {
    DDLogDebug(@"*");
    [self.categoryBabyAndChildButton toggleButton];
}

- (IBAction)filterForOther:(id)sender {
    DDLogDebug(@"*");
    [self.categoryOtherButton toggleButton];
}

@end

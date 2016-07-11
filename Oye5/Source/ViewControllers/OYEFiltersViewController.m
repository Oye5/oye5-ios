//
//  OYEFiltersViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 6/25/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEFiltersViewController.h"
#import "OYEUserDefaultsManager.h"
#import "UIButton+Extensions.h"

@interface OYEFiltersViewController ()

@property (nonatomic, weak) IBOutlet UIToolbar *toolbar;
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *titleItem;
@property (nonatomic, weak) IBOutlet UIButton *resetButton;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) IBOutlet UIView *filtersView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *filtersViewWidthConstraint;

@property (nonatomic, weak) IBOutlet UIView *distanceView;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) IBOutlet UIView *distanceSeparator;
@property (nonatomic, weak) IBOutlet UISlider *distanceSlider;

@property (nonatomic, weak) IBOutlet UIView *sortView;
@property (nonatomic, weak) IBOutlet UILabel *sortLabel;
@property (nonatomic, weak) IBOutlet UIView *sortSeparator;
@property (nonatomic, weak) IBOutlet UIButton *sortByNewestButton;
@property (nonatomic, weak) IBOutlet UIButton *sortByPriceLowToHighButton;
@property (nonatomic, weak) IBOutlet UIButton *sortByPriceHighToLowButton;

@property (nonatomic, weak) IBOutlet UIView *categoriesView;
@property (nonatomic, weak) IBOutlet UILabel *categoriesLabel;
@property (nonatomic, weak) IBOutlet UIView *categoriesSeparator;
@property (nonatomic, weak) IBOutlet UIButton *categoryElectronicsButton;
@property (nonatomic, weak) IBOutlet UIButton *categoryFashionAndAccessoriesButton;
@property (nonatomic, weak) IBOutlet UIButton *categoryHomeAndGardenButton;
@property (nonatomic, weak) IBOutlet UIButton *categoryBooksMoviesAndMusicButton;
@property (nonatomic, weak) IBOutlet UIButton *categorySportsAndLeisureButton;
@property (nonatomic, weak) IBOutlet UIButton *categoryCarsAndMotorsButton;
@property (nonatomic, weak) IBOutlet UIButton *categoryBabyAndChildButton;
@property (nonatomic, weak) IBOutlet UIButton *categoryOtherButton;

@property (nonatomic, weak) IBOutlet UIButton *saveButton;

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
    
    self.distanceSlider.minimumValue = 1.0;
    self.distanceSlider.maximumValue = 30.0;
    self.distanceSlider.tintColor = [UIColor oyeDarkBackgroundColor];
    [self.distanceSlider setThumbImage:[UIImage imageNamed:@"dot-black"] forState:UIControlStateNormal];
    
    [self resetDistanceFilter];
}

- (void)setupSortSection {
    [self.sortView setupCornerRadius];
    [self setupSection:NSLocalizedString(@"Sort By:", nil) label:self.sortLabel separator:self.sortSeparator];
    
    [self.sortByNewestButton setTitle:NSLocalizedString(@"Newest first", nil) forState:UIControlStateNormal];
    [self.sortByPriceLowToHighButton setTitle:NSLocalizedString(@"Price low to high", nil) forState:UIControlStateNormal];
    [self.sortByPriceHighToLowButton setTitle:NSLocalizedString(@"Price high to low", nil) forState:UIControlStateNormal];
    
    [self resetSortByFilter];
}

- (void)setupCategoriesSection {
    [self.categoriesView setupCornerRadius];
    [self setupSection:NSLocalizedString(@"Categories:", nil) label:self.categoriesLabel separator:self.categoriesSeparator];
    
    // Setup titles
    [self.categoryElectronicsButton setTitle:NSLocalizedString(@"Electronics", nil) forState:UIControlStateNormal];
    [self.categoryFashionAndAccessoriesButton setTitle:NSLocalizedString(@"Fasion & Accesories", nil) forState:UIControlStateNormal];
    [self.categoryHomeAndGardenButton setTitle:NSLocalizedString(@"Home & Garden", nil) forState:UIControlStateNormal];
    [self.categoryBooksMoviesAndMusicButton setTitle:NSLocalizedString(@"Books, Movies, & Music", nil) forState:UIControlStateNormal];
    [self.categorySportsAndLeisureButton setTitle:NSLocalizedString(@"Sports & Leisure", nil) forState:UIControlStateNormal];
    [self.categoryCarsAndMotorsButton setTitle:NSLocalizedString(@"Cars & Motors", nil) forState:UIControlStateNormal];
    [self.categoryBabyAndChildButton setTitle:NSLocalizedString(@"Baby & Children", nil) forState:UIControlStateNormal];
    [self.categoryOtherButton setTitle:NSLocalizedString(@"Other", nil) forState:UIControlStateNormal];
    
    [self resetCategoryFilters];
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

- (void)resetDistanceFilter {
    self.distanceSlider.value = [OYEUserDefaultsManager filterDistance];
}

- (void)resetSortByFilter {
    OYEFilterSortByType sortByType = [OYEUserDefaultsManager filterSortType];
    
    self.sortByNewestButton.selected = (sortByType == OYEFilterSortByTypeNewestFirst);
    self.sortByPriceLowToHighButton.selected = (sortByType == OYEFilterSortByTypePriceLowToHigh);
    self.sortByPriceHighToLowButton.selected = (sortByType == OYEFilterSortByTypePriceHighToLow);
}

- (void)resetCategoryFilters {
    NSUInteger categoryFilters = [OYEUserDefaultsManager filterCategories];
    
    self.categoryElectronicsButton.selected = (categoryFilters & OYEFilterCategoryTypeElectronics);
    self.categoryFashionAndAccessoriesButton.selected = (categoryFilters & OYEFilterCategoryTypeFashionAndAccessories);
    self.categoryHomeAndGardenButton.selected = (categoryFilters & OYEFilterCategoryTypeHomeAndGarden);
    self.categoryBooksMoviesAndMusicButton.selected = (categoryFilters & OYEFilterCategoryTypeBooksMoviesAndMusic);
    self.categorySportsAndLeisureButton.selected = (categoryFilters & OYEFilterCategoryTypeSportsAndLeisure);
    self.categoryCarsAndMotorsButton.selected = (categoryFilters & OYEFilterCategoryTypeCarsAndMotors);
    self.categoryBabyAndChildButton.selected = (categoryFilters & OYEFilterCategoryTypeBabyAndChild);
    self.categoryOtherButton.selected = (categoryFilters & OYEFilterCategoryTypeOther);
}

- (void)saveDistanceFilter {
    [OYEUserDefaultsManager setFilterDistance:self.distanceSlider.value];
}

- (void)saveSortByType {
    if (self.sortByNewestButton.selected) {
        [OYEUserDefaultsManager setFilterSortByType:OYEFilterSortByTypeNewestFirst];
    } else if (self.sortByPriceLowToHighButton.selected) {
        [OYEUserDefaultsManager setFilterSortByType:OYEFilterSortByTypePriceLowToHigh];
    } else {
        [OYEUserDefaultsManager setFilterSortByType:OYEFilterSortByTypePriceHighToLow];
    }
}

- (void)saveCategoryFilters {
    NSUInteger categoryFilters = 0;
    
    if (self.categoryElectronicsButton.selected) {
        categoryFilters |= OYEFilterCategoryTypeElectronics;
    }
    
    if (self.categoryFashionAndAccessoriesButton.selected) {
        categoryFilters |= OYEFilterCategoryTypeFashionAndAccessories;
    }
    
    if (self.categoryHomeAndGardenButton.selected) {
        categoryFilters |= OYEFilterCategoryTypeHomeAndGarden;
    }
    
    if (self.categoryBooksMoviesAndMusicButton.selected) {
        categoryFilters |= OYEFilterCategoryTypeBooksMoviesAndMusic;
    }
    
    if (self.categorySportsAndLeisureButton.selected) {
        categoryFilters |= OYEFilterCategoryTypeSportsAndLeisure;
    }
    
    if (self.categoryCarsAndMotorsButton.selected) {
        categoryFilters |= OYEFilterCategoryTypeCarsAndMotors;
    }
    
    if (self.categoryBabyAndChildButton.selected) {
        categoryFilters |= OYEFilterCategoryTypeBabyAndChild;
    }
    
    if (self.categoryOtherButton.selected) {
        categoryFilters |= OYEFilterCategoryTypeOther;
    }
    
    [OYEUserDefaultsManager setFilterCategories:categoryFilters];
}

- (void)verifySortyByFilter {
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

    [self resetDistanceFilter];
    [self resetSortByFilter];
    [self resetCategoryFilters];
}

- (IBAction)saveFilters:(id)sender {
    DDLogDebug(@"*");
    
    [self saveDistanceFilter];
    [self saveSortByType];
    [self saveCategoryFilters];

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
        [self verifySortyByFilter];
    }
}

- (IBAction)sortByPriceLowToHigh:(id)sender {
    DDLogDebug(@"*");
    [self.sortByPriceLowToHighButton toggleButton];
    if (self.sortByPriceLowToHighButton.selected) {
        self.sortByNewestButton.selected = NO;
        self.sortByPriceHighToLowButton.selected = NO;
    } else {
        [self verifySortyByFilter];
    }
}

- (IBAction)sortByPriceHighToLow:(id)sender {
    DDLogDebug(@"*");
    [self.sortByPriceHighToLowButton toggleButton];
    if (self.sortByPriceHighToLowButton.selected) {
        self.sortByNewestButton.selected = NO;
        self.sortByPriceLowToHighButton.selected = NO;
    } else {
        [self verifySortyByFilter];
    }
}

- (IBAction)filterForElectronics:(id)sender {
    DDLogDebug(@"*");
    [self.categoryElectronicsButton toggleButton];
}

- (IBAction)filterForFashionAndAccessories:(id)sender {
    DDLogDebug(@"*");
    [self.categoryFashionAndAccessoriesButton toggleButton];
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

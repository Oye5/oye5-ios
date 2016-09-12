//
//  OYECategoriesViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 2/21/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYESearchViewController.h"
#import "OYECategoryCollectionViewCell.h"
#import "OYESearchResultsCollectionViewController.h"
#import "OYEConstants.h"

typedef NS_ENUM(NSUInteger, CategoryType) {
    CategoryTypeFashionAndAccessories,
    CategoryTypeElectronics,
    CategoryTypeCarsAndMotors,
    CategoryTypeBabyAndChild,
    CategoryTypeHomeAndGarden,
    CategoryTypeBooksMoviesAndMusic,
    CategoryTypeSportsAndLeisure,
    CategoryTypeOther,
    CategoryTypeCount
};

static NSString * const CategoryCellIdentifier = @"OYECategoryCollectionViewCell";

@interface OYESearchViewController () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *categories;

@end

@implementation OYESearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupSearchBar];
    [self setupCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.width, self.navigationController.navigationBar.height)];
    searchBar.delegate = self;
    
    self.navigationItem.titleView = searchBar;
}


- (void)setupCollectionView {
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([OYECategoryCollectionViewCell class]) bundle:[NSBundle bundleForClass:[OYECategoryCollectionViewCell class]]] forCellWithReuseIdentifier:CategoryCellIdentifier];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(OYESearchResultsContentInset, OYESearchResultsContentInset, OYESearchResultsContentInset, OYESearchResultsContentInset);
    self.collectionView.backgroundColor = [UIColor oyeLightBackgroundColor];
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.minimumLineSpacing = OYESearchResultsContentInset;
}

- (NSString *)nameForCategoryType:(CategoryType)categoryType {
    switch (categoryType) {
        case CategoryTypeFashionAndAccessories:
            return NSLocalizedString(@"Fashion & Accessories", nil);
            
        case CategoryTypeElectronics:
            return NSLocalizedString(@"Electronics", nil);
            
        case CategoryTypeCarsAndMotors:
            return NSLocalizedString(@"Cars & Motors", nil);
            
        case CategoryTypeBabyAndChild:
            return NSLocalizedString(@"Baby & Child", nil);
            
        case CategoryTypeHomeAndGarden:
            return NSLocalizedString(@"Home & Garden", nil);
            
        case CategoryTypeBooksMoviesAndMusic:
            return NSLocalizedString(@"Books, Movies & Music", nil);
            
        case CategoryTypeSportsAndLeisure:
            return NSLocalizedString(@"Sports & Leisure", nil);
            
        case CategoryTypeOther:
            return NSLocalizedString(@"Other", nil);
            
        default:
            return @"";
    }
}

- (UIImage *)imageForCategoryType:(CategoryType)categoryType {
    switch (categoryType) {
        case CategoryTypeFashionAndAccessories:
            return [UIImage imageNamed:@"category-fashionAndAccessories"];
            
        case CategoryTypeElectronics:
            return [UIImage imageNamed:@"category-fashionAndAccessories"];
            
        case CategoryTypeCarsAndMotors:
            return [UIImage imageNamed:@"category-fashionAndAccessories"];
            
        case CategoryTypeBabyAndChild:
            return [UIImage imageNamed:@"category-fashionAndAccessories"];
            
        case CategoryTypeHomeAndGarden:
            return [UIImage imageNamed:@"category-fashionAndAccessories"];
            
        case CategoryTypeBooksMoviesAndMusic:
            return [UIImage imageNamed:@"category-fashionAndAccessories"];
            
        case CategoryTypeSportsAndLeisure:
            return [UIImage imageNamed:@"category-fashionAndAccessories"];
            
        case CategoryTypeOther:
            return [UIImage imageNamed:@"category-fashionAndAccessories"];
            
       default:
            return nil;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return CategoryTypeCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OYECategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CategoryCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.titleLabel.text = [self nameForCategoryType:indexPath.row];
    cell.imageView.image = [self imageForCategoryType:indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DDLogDebug(@"*");
    
    OYESearchResultsCollectionViewController *viewController = [[OYESearchResultsCollectionViewController alloc] initWithNibName:NSStringFromClass([OYESearchResultsCollectionViewController class]) bundle:nil];
    viewController.title = [self nameForCategoryType:indexPath.row];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    
    CGFloat width = (collectionView.width  - flowLayout.minimumInteritemSpacing - 2 * OYESearchResultsContentInset) / 2;
    CGSize cellSize = CGSizeMake(width, width * (3.0 / 4.0));
    
    return cellSize;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    DDLogDebug(@"*");
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    DDLogDebug(@"*");
}

@end

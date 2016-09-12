//
//  OYEShopViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import CoreLocation.CLLocation;

#import "OYEShopViewController.h"
#import "OYEItemViewController.h"
#import "OYELocationViewController.h"
#import "OYEFiltersViewController.h"
#import "OYEItemCollectionViewCell.h"
#import "OYEItem.h"
#import "OYEItemManager.h"
#import "OYESegmentedControl.h"
#import "OYEConstants.h"

#import "UIColor+Extensions.h"
#import "UIView+Extensions.h"

@interface OYEShopViewController () <UISearchBarDelegate, OYESegmentedControlDelegate, OYELocationViewControllerDelegate, OYEFiltersViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *segmentedControlContainer;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray<OYEItem *> *items;

@end

@implementation OYEShopViewController

static NSString * const reuseIdentifier = @"OYEItemCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
        
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.view.backgroundColor = [UIColor oyeMediumBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNavigationBar];
    [self setupSegmentedControlContainer];
    [self setupCollectionView];
    
    self.items = [OYEItemManager getItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationBar {
    [self setupLocationButton];
    [self setupSearchBar];
    [self setupFilterButton];
}

- (void)setupLocationButton {
    UIImage *image = [UIImage imageNamed:@"location"];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeLocation:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = buttonItem;
}

- (void)setupSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.width, self.navigationController.navigationBar.height)];
    searchBar.delegate = self;
    
    self.navigationItem.titleView = searchBar;
}

- (void)setupFilterButton {
    UIImage *image = [UIImage imageNamed:@"filter"];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(filterItems:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)setupSegmentedControlContainer {
    OYESegmentedControl *segmentedControl = [[OYESegmentedControl alloc] initWithFrame:CGRectMake(0, 0, self.segmentedControlContainer.width, self.segmentedControlContainer.height) titles:@[NSLocalizedString(@"FEATURED", nil), NSLocalizedString(@"BROWSE", nil)] delegate:self];
    [segmentedControl selectSegment:0];
    
    [self.segmentedControlContainer addSubview:segmentedControl];
    
    [self.segmentedControlContainer addContraintsToAddView:segmentedControl];
    
    self.segmentedControlContainer.backgroundColor = [UIColor clearColor];
}

- (void)setupCollectionView {
    
    // Do any additional setup after loading the view.
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(OYESearchResultsContentInset, OYESearchResultsContentInset, OYESearchResultsContentInset, OYESearchResultsContentInset);
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([OYEItemCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)configureCell:(OYEItemCollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    OYEItem *item = self.items[indexPath.row];
    
    cell.item = item;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OYEItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    OYEItemViewController *viewController = [OYEItemViewController new];
    viewController.item = self.items[indexPath.row];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    
    CGSize cellSize = CGSizeMake((self.collectionView.width  - flowLayout.minimumInteritemSpacing - 2 * OYESearchResultsContentInset) / 2, 250);
    
    return cellSize;
}

#pragma mark - OYESegmentedControlDelegate

- (void)didSelectSegment:(NSUInteger)segment {
    DDLogDebug(@"Segment: %lu", (unsigned long)segment);
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    DDLogDebug(@"*");
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    DDLogDebug(@"*");
}

#pragma mark - OYELocationViewControllerDelegate

- (void)didCancelLocationViewController:(OYELocationViewController *)viewController {
    DDLogDebug(@"*");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didChangeLocationViewController:(OYELocationViewController *)viewController {
    DDLogDebug(@"*");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - OYEFiltersViewControllerDelegate

- (void)didCancelFiltersViewController:(OYEFiltersViewController *)viewController {
    DDLogDebug(@"*");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didChangeFiltersViewController:(OYEFiltersViewController *)viewController {
    DDLogDebug(@"*");
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.collectionView reloadData];
    }];
}

#pragma mark - Actions

- (void)changeLocation:(UIButton *)sender {
    DDLogDebug(@"*");
    
    OYELocationViewController *viewController = [OYELocationViewController viewControllerWithDelegate:self];
    
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)filterItems:(UIButton *)sender {
    DDLogDebug(@"*");
    
    OYEFiltersViewController *viewController = [OYEFiltersViewController viewControllerWithDelegate:self];
    
    [self presentViewController:viewController animated:YES completion:nil];
}

@end

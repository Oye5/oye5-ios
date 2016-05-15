//
//  OYEHomeCollectionViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import CoreLocation.CLLocation;

#import "OYEExploreViewController.h"
#import "OYEItemCollectionViewCell.h"
#import "OYEItem.h"
#import "OYEItemViewController.h"
#import "OYEItemManager.h"
#import "OYESegmentedControl.h"

#import "UIColor+Extensions.h"
#import "UIView+Extensions.h"

static CGFloat const OYEExploreCollectionViewVerticalInset = 5.0;
static CGFloat const OYEExploreCollectionViewHorizontalInset = 5.0;

@interface OYEExploreViewController () <OYESegmentedControlDelegate>

@property (weak, nonatomic) IBOutlet UIView *segmentedControlContainer;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray<OYEItem *> *items;

@end

@implementation OYEExploreViewController

static NSString * const reuseIdentifier = @"OYEItemCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.view.backgroundColor = [UIColor oyeLightGrayBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupSegmentedControlContainer];
    [self setupCollectionView];
    
    self.items = [OYEItemManager getItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    self.collectionView.contentInset = UIEdgeInsetsMake(OYEExploreCollectionViewVerticalInset, OYEExploreCollectionViewHorizontalInset, OYEExploreCollectionViewVerticalInset, OYEExploreCollectionViewHorizontalInset);
    
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

#pragma mark <UICollectionViewDataSource>

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

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    OYEItemViewController *viewController = [OYEItemViewController new];
    viewController.item = self.items[indexPath.row];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    
    CGSize cellSize = CGSizeMake((self.collectionView.width  - flowLayout.minimumLineSpacing - 2 * OYEExploreCollectionViewHorizontalInset) / 2, 250);
    
    return cellSize;
}

#pragma mark - OYESegmentedControlDelegate

- (void)didSelectSegment:(NSUInteger)segment {
    DDLogDebug(@"*");
}

@end

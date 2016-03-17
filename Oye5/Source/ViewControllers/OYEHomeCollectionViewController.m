//
//  OYEHomeCollectionViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import CoreLocation.CLLocation;

#import "OYEHomeCollectionViewController.h"
#import "OYEItemCollectionViewCell.h"
#import "OYEItem.h"
#import "OYEItemViewController.h"

#import "UIColor+Extensions.h"

@interface OYEHomeCollectionViewController ()

@end

@implementation OYEHomeCollectionViewController

static NSString * const reuseIdentifier = @"OYEItemCollectionViewCell";

- (NSArray<OYEItem *> *)items
{
    static NSArray<OYEItem *> *items;
    
    if (!items) {
        NSMutableArray<OYEItem *> *mutableItems = [NSMutableArray array];
        for (NSInteger i = 0; i < 100; i++) {
            OYEItem *anItem = [OYEItem new];
            anItem.itemTitle = [NSString stringWithFormat:@"Title %ld", (long)i];
            anItem.itemDescription = [NSString stringWithFormat:@"Item %ld is new.", (long)i];
            NSMutableArray *images = [NSMutableArray array];
            for (NSInteger i = 0; i < 12; i++) {
                [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"image-%ld", (long)i]]];
            }
            anItem.images = @[@"http://moviecitynews.com/wp-content/uploads/2015/06/inside-out-651.jpg",
                              @"https://cdn.amctheatres.com/titles/images/Poster/Large/2472_io-superticket-1sht-comp24a_B756.jpg",
                              @"https://cdn.amctheatres.com/Media/Default/images/Inside-Out-Meet-your-emotions-2.png",
                              @"https://cdn.amctheatres.com/Media/Default/images/insideout.jpg",
                              @"https://cdn.amctheatres.com/Media/Default/images/Inside%20Out.jpg",
                              @"https://cdn.amctheatres.com/titles/images/Hero/HeroLarge/2591_movie-featured-insideout-104_D7EA.jpg"];
            anItem.currencyCode = @"INR";
            anItem.price = @(i);
            
            anItem.city = @"Mumbai";
            anItem.state = @"Maharashtra";
            anItem.country = @"India";
            anItem.postalCode = @"12345";
            anItem.location = [[CLLocation alloc] initWithLatitude:18.9750 longitude:72.8258];
            
            [mutableItems addObject:anItem];
        }
        
        items = mutableItems;
    }
    
    return items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([OYEItemCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    self.collectionView.backgroundColor = [UIColor oyeBackgroundColor];
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

- (void)configureCell:(OYEItemCollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    OYEItem *item = [self items][indexPath.row];
    
    cell.item = item;
    
    cell.backgroundColor = [UIColor darkGrayColor];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self items].count;
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
    viewController.item = [self items][indexPath.row];
    
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
    
    CGSize cellSize = CGSizeMake((CGRectGetWidth(self.view.frame) - flowLayout.minimumInteritemSpacing) / 2, 100);
    
    return cellSize;
}


@end

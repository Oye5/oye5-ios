//
//  OYESearchResultsCollectionViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 9/5/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYESearchResultsCollectionViewController.h"
#import "OYEItemViewController.h"
#import "OYEItemCollectionViewCell.h"
#import "OYEItemManager.h"
#import "OYEConstants.h"

@interface OYESearchResultsCollectionViewController ()

@property (nonatomic, strong) NSArray *items;

@end

@implementation OYESearchResultsCollectionViewController

static NSString * const reuseIdentifier = @"OYEItemCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
        
    [self setupUI];
    [self loadData];
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

- (void)loadData {
    self.items = [OYEItemManager getItems];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor oyeMediumBackgroundColor];
    
    [self setupCollectionView];
}

- (void)setupCollectionView {
    
    // Do any additional setup after loading the view.
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(OYESearchResultsContentInset, OYESearchResultsContentInset, OYESearchResultsContentInset, OYESearchResultsContentInset);
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([OYEItemCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
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
    OYEItem *item = self.items[indexPath.row];
    
    cell.item = item;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

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
    
    CGSize cellSize = CGSizeMake((self.collectionView.width  - flowLayout.minimumLineSpacing - 2 * OYESearchResultsContentInset) / 2, 250);
    
    return cellSize;
}

@end

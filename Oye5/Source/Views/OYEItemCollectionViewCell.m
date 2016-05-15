//
//  OYEItemCollectionViewCell.m
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import AFNetworking;

#import "OYEItemCollectionViewCell.h"
#import "OYEItem.h"

#import "UIColor+Extensions.h"
#import "UIFont+Extensions.h"

@interface OYEItemCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *shawdowView;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) OYEItem *item;

@end

@implementation OYEItemCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    
    [self setupShawdowView];
    [self setupCardView];
    [self setupImageView];
    [self setupDescriptionTextView];
    [self setupDistanceLabel];
    [self setupPriceLabel];
}

#pragma mark - Private

- (void)setupShawdowView {
    self.shawdowView.layer.shadowOpacity = 0.1;
    self.shawdowView.layer.shadowRadius = 1;
    self.shawdowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shawdowView.backgroundColor = [UIColor clearColor];
}

- (void)setupCardView {
    self.cardView.layer.cornerRadius = 2.0;
    self.cardView.layer.masksToBounds = YES;
}

- (void)setupImageView
{
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setupDescriptionTextView {
    self.descriptionTextView.font = [UIFont oyeFontOfSize:14];
    self.descriptionTextView.textColor = [UIColor oyeDarkTextColor];
    self.descriptionTextView.backgroundColor = [UIColor oyeWhiteBackGroundColor];
}

- (void)setupDistanceLabel {
    self.distanceLabel.font = [UIFont oyeFontOfSize:14];
    self.distanceLabel.textColor = [UIColor oyeMediumTextColor];
    self.distanceLabel.backgroundColor = [UIColor oyeWhiteBackGroundColor];
}

- (void)setupPriceLabel {
    self.priceLabel.font = [UIFont boldOyeFontOfSize:14];
    self.priceLabel.textColor = [UIColor oyeDarkTextColor];
    self.priceLabel.backgroundColor = [UIColor oyeWhiteBackGroundColor];
}

#pragma mark - Override

- (void)setItem:(OYEItem *)item {
    _item = item;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:self.item.images.firstObject]];
    self.descriptionTextView.text = item.itemDescription;
#warning Need to link to distance from user
    self.distanceLabel.text = [NSString stringWithFormat:@"%.1f km", (rand() % 100) / 100.0];
    self.priceLabel.text = [item priceString];
}

@end

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

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) OYEItem *item;

@end

@implementation OYEItemCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setupImageView];
    [self setupLabel:self.priceLabel];
    [self setupLabel:self.descriptionLabel];
}

#pragma mark - Private

- (void)setupImageView
{
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setupLabel:(UILabel *)label {
    label.font = [UIFont oyeFontOfSize:12];
    label.textColor = [UIColor oyeLightTextColor];
}

#pragma mark - Override

- (void)setItem:(OYEItem *)item {
    _item = item;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:self.item.images.firstObject]];
    self.descriptionLabel.text = item.itemDescription;
    self.priceLabel.text = [item priceString];
}

@end

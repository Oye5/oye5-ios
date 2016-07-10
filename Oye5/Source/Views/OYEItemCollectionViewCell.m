//
//  OYEItemCollectionViewCell.m
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import AFNetworking;
@import CoreLocation;

#import "OYEItemCollectionViewCell.h"
#import "OYEItem.h"
#import "OYEUserLocationManager.h"
#import "OYELocation.h"

static CGFloat const OYEIMaxDistance = 100000.0;

@interface OYEItemCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *shawdowView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowViewLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowViewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowViewTrailingConstraint;
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

#pragma mark - Public

- (void)setLeftMargin:(CGFloat)leftMargin {
    self.shadowViewLeadingConstraint.constant = leftMargin;
}

- (void)setRightMargin:(CGFloat)rightMargin {
    self.shadowViewTrailingConstraint.constant = rightMargin;
}

#pragma mark - Private

- (void)setupShawdowView {
    self.shawdowView.layer.shadowOpacity = 0.1;
    self.shawdowView.layer.shadowRadius = 1;
    self.shawdowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shawdowView.backgroundColor = [UIColor clearColor];
}

- (void)setupCardView {
    [self.cardView setupCornerRadius];
}

- (void)setupImageView
{
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds = YES;
}

- (void)setupDescriptionTextView {
    self.descriptionTextView.font = [UIFont oyeFontOfSize:14];
    self.descriptionTextView.textColor = [UIColor oyeDarkTextColor];
    self.descriptionTextView.backgroundColor = [UIColor oyeLightBackgroundColor];
}

- (void)setupDistanceLabel {
    self.distanceLabel.font = [UIFont oyeFontOfSize:14];
    self.distanceLabel.textColor = [UIColor oyeMediumTextColor];
    self.distanceLabel.backgroundColor = [UIColor oyeLightBackgroundColor];
}

- (void)setupPriceLabel {
    self.priceLabel.font = [UIFont boldOyeFontOfSize:14];
    self.priceLabel.textColor = [UIColor oyeDarkTextColor];
    self.priceLabel.backgroundColor = [UIColor oyeLightBackgroundColor];
}

#pragma mark - Override

- (void)setItem:(OYEItem *)item {
    _item = item;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:self.item.images.firstObject]];
    self.descriptionTextView.text = item.itemDescription;
    CLLocation *currentLocation = [OYEUserLocationManager currentLocation];
    if (currentLocation) {
        CLLocationCoordinate2D itemCoordinate = [item.location coordinate];
        CLLocation *itemLocation = [[CLLocation alloc] initWithLatitude:itemCoordinate.latitude longitude:itemCoordinate.longitude];
        CLLocationDistance distance = [currentLocation distanceFromLocation:itemLocation];
        if (distance > OYEIMaxDistance) {
            self.distanceLabel.text = NSLocalizedString(@"100+ km", nil);
        } else {
            self.distanceLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%.1f km", nil), distance];
        }
    } else {
        self.distanceLabel.text = NSLocalizedString(@"TBD", nil);
    }
    self.priceLabel.text = [item priceString];
}

@end

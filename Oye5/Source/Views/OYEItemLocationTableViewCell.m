//
//  OYEItemLocationTableViewCell.m
//  Oye5
//
//  Created by Rita Kyauk on 3/13/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import MapKit;
@import CoreLocation;

#import "OYEItemLocationTableViewCell.h"
#import "OYEItem.h"
#import "OYEItemLocationAnnotation.h"

#import "UIFont+Extensions.h"
#import "UIColor+Extensions.h"

@interface OYEItemLocationTableViewCell () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) OYEItem *item;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation OYEItemLocationTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setupLocationManager];
    [self setupUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight:(NSDictionary *)data {
    OYEItem *item = data[OYETableViewCellHeightItemKey];
    CGFloat width = [data[OYETableViewCellHeightWidthKey] floatValue];
    
    CGSize titleSize = [item.itemDescription sizeWithAttributes:@{NSFontAttributeName:[self locationLabelFont]}];
    CGFloat titleBuffer = 16;
    CGFloat descriptionHeight = ceil((titleSize.width / width)) * [self locationLabelFont].lineHeight + titleBuffer;
    
    CGFloat mapHeight = 2 * width / 3;
    
    CGFloat height = descriptionHeight + mapHeight;
    
    return height;
}

#pragma mark - Private

+ (UIFont *)locationLabelFont {
    return [UIFont oyeFontOfSize:12];
}

- (void)setupLocationManager {
    self.locationManager = [CLLocationManager new];
    [self.locationManager requestWhenInUseAuthorization];
}

- (void)setupUI {
    [self setupLocationLabel];
    [self setupMapView];
}

- (void)setupLocationLabel {
    self.locationLabel.font = [[self class] locationLabelFont];
    self.locationLabel.textColor = [UIColor oyeMediumTextColor];
}

- (void)setupMapView {
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
}

- (void)setupWithItem {
    self.locationLabel.text = [NSString stringWithFormat:@"%@, %@", self.item.city, self.item.state];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotation:[OYEItemLocationAnnotation annotationWithItem:self.item]];
    
    [self.mapView setCenterCoordinate:self.item.location.coordinate animated:YES];
}

#pragma mark - Public

- (void)setItem:(OYEItem *)item {
    _item = item;
    
    [self setupWithItem];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[OYEItemLocationAnnotation class]]) {
        NSString *reuseIdentifer = @"OYEItemLocationTableViewCell";
        
        MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifer];
        
        annotationView.pinTintColor = [MKPinAnnotationView greenPinColor];
        
        return annotationView;
    }
    
    return nil;
}

@end

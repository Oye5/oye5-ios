//
//  OYEItemLocationCollectionViewCell.m
//  Oye5
//
//  Created by Rita Kyauk on 6/13/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import MapKit;
@import CoreLocation;

#import "OYEItemLocationCollectionViewCell.h"
#import "OYEItem.h"
#import "OYELocation.h"
#import "OYEItemLocationAnnotation.h"
#import "OYELabelAnnotationView.h"
#import "UIFont+Extensions.h"
#import "UIColor+Extensions.h"
#import "UIView+Extensions.h"

static CGFloat const OYEDefaultRadiusInMiles = 5.0;
static CGFloat const MetersPerMile = 1609.34;

@interface OYEItemLocationCollectionViewCell () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (strong, nonatomic) OYEItem *item;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation OYEItemLocationCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
    [self setupLocationManager];
    [self setupUI];
}

+ (CGFloat)cellHeight:(NSDictionary *)data {
    OYEItem *item = data[OYECollectionViewCellHeightItemKey];
    CGFloat width = [data[OYECollectionViewCellHeightWidthKey] floatValue];
    
    CGSize titleSize = [item.itemDescription sizeWithAttributes:@{NSFontAttributeName:[self locationLabelFont]}];
    CGFloat titleBuffer = 16;
    CGFloat descriptionHeight = ceil((titleSize.width / width)) * [self locationLabelFont].lineHeight + titleBuffer;
    
    CGFloat mapHeight = width / 2;
    
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
    self.backgroundColor = [UIColor oyeLightBackgroundColor];
    
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
    // Location string
    NSMutableAttributedString *locationString = [[NSMutableAttributedString alloc] initWithString:@"Pick-up in: "
                                                                                       attributes:@{NSFontAttributeName:[UIFont mediumOyeFontOfSize:12],
                                                                                                    NSForegroundColorAttributeName:[UIColor oyeMediumTextColor]}];
    NSAttributedString *locationDescription = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@, %@", self.item.location.city, self.item.location.state]
                                                                              attributes:@{NSFontAttributeName:[UIFont mediumOyeFontOfSize:12],
                                                                                           NSForegroundColorAttributeName:[UIColor oyeDarkTextColor]}];
    [locationString appendAttributedString:locationDescription];
    self.locationLabel.attributedText = locationString;
    
    // Clear annotations
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotation:[OYEItemLocationAnnotation annotationWithItem:self.item]];
    
    // Set visible area
    CLLocationCoordinate2D coordinate = [self.item.location coordinate];
    double sizeInMapPoints = MKMapPointsPerMeterAtLatitude(coordinate.latitude) * OYEDefaultRadiusInMiles * MetersPerMile;
    MKMapPoint mapPoint = MKMapPointForCoordinate(coordinate);
    [self.mapView setVisibleMapRect:MKMapRectMake(mapPoint.x - sizeInMapPoints / 2.0, mapPoint.y - sizeInMapPoints / 2.0, sizeInMapPoints, sizeInMapPoints) edgePadding:UIEdgeInsetsMake(50, 50, 50, 50) animated:YES];
    
    // Clear all overlays
    [self.mapView removeOverlays:self.mapView.overlays];
    
    // Add map tint overlay
    MKMapPoint points[4] = {{0, 0},
                            {MKMapSizeWorld.width, 0},
                            {MKMapSizeWorld.width, MKMapSizeWorld.height},
                            {0, MKMapSizeWorld.height}};
    MKPolygon *square = [MKPolygon polygonWithPoints:points count:4];
    [self.mapView addOverlay:square];
    
    // Add circle
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:coordinate radius:(OYEDefaultRadiusInMiles * MetersPerMile)];
    [self.mapView addOverlay:circle];
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
        
        OYELabelAnnotationView *annotationView = (OYELabelAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifer];
        if (!annotationView) {
            annotationView = [[OYELabelAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifer];
        }
        [annotationView setText:NSLocalizedString(@"5 km", nil)];
        
        return annotationView;
    }
    
    return nil;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKCircle class]]) {
        MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithCircle:overlay];
        renderer.lineWidth = 2.0;
        renderer.strokeColor = [UIColor oyePrimaryColor];
        renderer.fillColor = [UIColor oyePrimaryColorWithAlpha:0.55];
        
        return renderer;
    } else if ([overlay isKindOfClass:[MKPolygon class]]) {
        MKPolygonRenderer *renderer = [[MKPolygonRenderer alloc] initWithPolygon:overlay];
        renderer.fillColor = [UIColor colorWithWhite:0 alpha:0.75];
        
        return renderer;
    }
    
    return nil;
}

#pragma mark - IBAction

- (IBAction)didTapPickupButton:(id)sender {
    DDLogDebug(@"*");
}

@end

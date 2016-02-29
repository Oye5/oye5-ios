//
//  OYEItemViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 2/28/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEItemViewController.h"
#import "OYEItem.h"

#import "UIColor+Extensions.h"
#import "UIFont+Extensions.h"

@interface OYEItemViewController ()

@property (strong, nonatomic) OYEItem *item;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *firstLineView;
@property (weak, nonatomic) IBOutlet UIView *secondLineView;

@end

@implementation OYEItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)setupUI {
    [self setupImageView];
    [self setupPriceLabel];
    [self setupDescriptionTitleLabel];
    [self setupDescriptionLabel];
    [self setupLineView:self.firstLineView];
    [self setupLineView:self.secondLineView];
    
    if (self.item) {
        [self setupWithItem];
    }
}

- (void)setupImageView {
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.backgroundColor = [UIColor oyeBackgroundColor];
}

- (void)setupPriceLabel {
    self.priceLabel.font = [UIFont boldOyeFontOfSize:16];
    self.priceLabel.textColor = [UIColor oyeLightTextColor];
}

- (void)setupDescriptionTitleLabel {
    self.descriptionTitleLabel.font = [UIFont oyeFontOfSize:12];
    self.descriptionTitleLabel.textColor = [UIColor oyeMediumTextColor];
}

- (void)setupDescriptionLabel {
    self.descriptionLabel.font = [UIFont oyeFontOfSize:14];
    self.descriptionLabel.textColor = [UIColor oyeDarkTextColor];
}

- (void)setupLineView:(UIView *)lineView {
    lineView.backgroundColor = [UIColor oyeLineSeparatorColor];
}

- (void)setupWithItem {
    self.imageView.image = self.item.image;
    self.priceLabel.text = [self.item priceString];
    self.descriptionLabel.text = self.item.itemDescription;
}

#pragma mark - Override

- (void)setItem:(OYEItem *)item {
    _item = item;
    
    [self setupWithItem];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  OYEItemImageViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 3/13/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import AFNetworking;

#import "OYEItemImageViewController.h"

@interface OYEItemImageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) NSString *imageURL;

@end

@implementation OYEItemImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupImageView];
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

#pragma mark - Private

- (void)setupImageView {
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
 
    [self setupImageViewWithImageURL];
}

- (void)setupImageViewWithImageURL {
    if (self.imageURL) {
        NSURL *url = [NSURL URLWithString:self.imageURL];
        
        [self.imageView setImageWithURL:url];
        //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        //    [self.imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        //        DDLogDebug(@"download image successfully");
        //    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        //        DDLogDebug(@"download image failed with error %@", error);
        //        DDLogDebug(@"response %@", response);
        //    }];
    }
}

#pragma mark - Public

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    
    [self setupImageViewWithImageURL];
}

@end

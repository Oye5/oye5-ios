//
//  OYELocationViewController.h
//  Oye5
//
//  Created by Rita Kyauk on 7/16/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OYELocationViewController;

@protocol OYELocationViewControllerDelegate <NSObject>

- (void)didCancelLocationViewController:(OYELocationViewController *)viewController;
- (void)didChangeLocationViewController:(OYELocationViewController *)viewController;

@end

@interface OYELocationViewController : UIViewController

+ (instancetype)viewControllerWithDelegate:(id<OYELocationViewControllerDelegate>)delegate;

@end

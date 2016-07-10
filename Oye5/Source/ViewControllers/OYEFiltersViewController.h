//
//  OYEFiltersViewController.h
//  Oye5
//
//  Created by Rita Kyauk on 6/25/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEBaseViewController.h"

@class OYEFiltersViewController;

@protocol OYEFiltersViewControllerDelegate <NSObject>

- (void)didCancelFiltersViewController:(OYEFiltersViewController *)viewController;
- (void)didSaveFiltersViewController:(OYEFiltersViewController *)viewController;

@end

@interface OYEFiltersViewController : OYEBaseViewController

+ (instancetype)viewControllerWithDelegate:(id<OYEFiltersViewControllerDelegate>)delegate;

@end

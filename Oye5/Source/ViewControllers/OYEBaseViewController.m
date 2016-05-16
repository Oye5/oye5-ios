//
//  OYEBaseViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 5/15/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEBaseViewController.h"

@interface OYEBaseViewController ()

@end

@implementation OYEBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.topItem.title = @"";
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

@end

//
//  OYEChatsViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 2/27/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEChatsViewController.h"
#import "OYELoggedOutViewController.h"
#import "OYEChatViewController.h"

static NSString * const OYEChatsCellReuseIdentifier = @"OYEChatsCell";

typedef NS_ENUM(NSUInteger, OYEChatsSectionType) {
    OYEChatsSectionTypeSelling,
    OYEChatsSectionTypeBuying,
    OYEChatsSectionTypeCount
};

@interface OYEChatsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OYEChatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)setupTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:OYEChatsCellReuseIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return OYEChatsSectionTypeCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case OYEChatsSectionTypeSelling:
            return 1;
        case OYEChatsSectionTypeBuying:
            return 1;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OYEChatsCellReuseIdentifier forIndexPath:indexPath];
    switch (indexPath.section) {
        case OYEChatsSectionTypeSelling:
            cell.textLabel.text = @"Sell cell";
            return cell;
        case OYEChatsSectionTypeBuying:
            cell.textLabel.text = @"Buy cell";
            return cell;
        default:
            return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case OYEChatsSectionTypeSelling:
            return NSLocalizedString(@"Selling", nil);
        case OYEChatsSectionTypeBuying:
            return NSLocalizedString(@"Buying", nil);
        default:
            return nil;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OYEChatViewController *viewController = [OYEChatViewController new];
    
    [self.navigationController pushViewController:viewController animated:YES];
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

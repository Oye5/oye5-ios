//
//  OYEChatMessageTableViewCell.h
//  Oye5
//
//  Created by Rita Kyauk on 4/24/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OYEChatMessage;

@interface OYEChatMessageTableViewCell : UITableViewCell

@property (strong, nonatomic) OYEChatMessage *message;

+ (CGFloat)cellHeightWithMessage:(NSString *)message width:(CGFloat)width;

@end

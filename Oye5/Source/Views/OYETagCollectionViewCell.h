//
//  OYETagCollectionViewCell.h
//  Oye5
//
//  Created by Rita Kyauk on 6/12/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OYETagCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

+ (UIFont *)font;

@end

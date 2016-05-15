//
//  OYEUnderlineButton.m
//  Oye5
//
//  Created by Rita Kyauk on 5/14/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEUnderlineButton.h"
#import "UIColor+Extensions.h"
#import "UIFont+Extensions.h"

@interface OYEUnderlineButton ()

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation OYEUnderlineButton

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setTitleColor:[UIColor oyeMediumTextColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor oyeDarkTextColor] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor oyeMediumTextColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor oyeMediumTextColor] forState:UIControlStateDisabled];
    
    self.titleLabel.font = [UIFont boldOyeFontOfSize:16];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.lineView.backgroundColor = [UIColor oyeDarkTextColor];
    self.lineView.hidden = YES;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.lineView.hidden = !selected;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

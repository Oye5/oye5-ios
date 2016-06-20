//
//  OYELabelAnnotationView.m
//  Oye5
//
//  Created by Rita Kyauk on 6/19/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYELabelAnnotationView.h"
#import "UIFont+Extensions.h"
#import "UIColor+Extensions.h"

@interface OYELabelAnnotationView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation OYELabelAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation
                   reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textColor = [UIColor oyeLightTextColor];
        self.label.font = [UIFont oyeFontOfSize:16];
        
        [self addSubview:self.label];
    }
    
    return self;
}

- (void)setText:(NSString *)text {
    self.label.text = text;
    [self.label sizeToFit];
    
    self.label.left = -self.label.size.width / 2.0;
    self.label.top = -self.label.size.height / 2.0;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  OYEChatMessageTableViewCell.m
//  Oye5
//
//  Created by Rita Kyauk on 4/24/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEChatMessageTableViewCell.h"
#import "OYEChatMessage.h"

#define OYE_CHAT_MESSAGE_FONT               [UIFont mediumOyeFontOfSize:16]
#define OYE_CHAT_MESSAGE_VERTICAL_INSET             5
#define OYE_CHAT_MESSAGE_HORIZONTAL_INSET           5
#define OYE_CHAT_MESSAGE_HORIZONTAL_OFFSET          6
#define OYE_CHAT_MESSAGE_HORIZONTAL_ADDED_OFFSET    50
#define OYE_CHAT_MESSAGE_VERTICAL_OFFSET            2
#define OYE_CHAT_CONTENT_VERTICAL_MARGIN            8
#define OYE_CHAT_CONTENT_HORIZONTAL_MARGIN          8

@interface OYEChatMessageTableViewCell ()

@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageTextViewLeadingMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageTextViewTrailingMargin;

@end

@implementation OYEChatMessageTableViewCell

+ (CGFloat)cellHeightWithMessage:(NSString *)message width:(CGFloat)width {
    CGRect rect = [self rectForMessage:message width:width];
    
    return (rect.size.height
            + (2 * OYE_CHAT_CONTENT_VERTICAL_MARGIN)
            + (2 * OYE_CHAT_MESSAGE_VERTICAL_INSET)
            + (2 * OYE_CHAT_MESSAGE_VERTICAL_OFFSET));
}

+ (CGRect)rectForMessage:(NSString *)message width:(CGFloat)width {
    CGFloat widthWithoutMargins = [self horizontalSpaceForCellWidth:width] - OYE_CHAT_MESSAGE_HORIZONTAL_ADDED_OFFSET;
    
    CGRect rect = [message boundingRectWithSize:CGSizeMake(widthWithoutMargins, CGFLOAT_MAX)
                                        options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName:OYE_CHAT_MESSAGE_FONT}
                                        context:nil];
    
    return rect;
}

+ (CGFloat)horizontalSpaceForCellWidth:(CGFloat)width {
    return width
            - (2 * OYE_CHAT_MESSAGE_HORIZONTAL_INSET)
            - (2 * OYE_CHAT_CONTENT_HORIZONTAL_MARGIN)
            - (2 * OYE_CHAT_MESSAGE_HORIZONTAL_OFFSET);
}

- (void)awakeFromNib {
    // Initialization code
    [self setupMessageTextView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessage:(OYEChatMessage *)message {
    _message = message;
    
    self.messageTextView.text = message.message;
    
    CGRect messageRect = [[self class] rectForMessage:message.message width:self.width];
    CGFloat messageOffset = ([[self class] horizontalSpaceForCellWidth:self.width] - messageRect.size.width);
    
    if (message.type == OYEChatMessageTypeIncoming) {
        self.messageTextView.backgroundColor = [UIColor lightGrayColor];
        self.messageTextView.textColor = [UIColor oyeDarkTextColor];
        self.messageTextViewLeadingMargin.constant = 0;
        self.messageTextViewTrailingMargin.constant = -messageOffset;
    } else {
        self.messageTextView.backgroundColor = [UIColor blueColor];
        self.messageTextView.textColor = [UIColor whiteColor];
        self.messageTextViewLeadingMargin.constant = messageOffset;
        self.messageTextViewTrailingMargin.constant = 0;
    }
}

#pragma mark - Private

- (void)setupMessageTextView {
    self.messageTextView.font = OYE_CHAT_MESSAGE_FONT;
    self.messageTextView.layer.cornerRadius = 15;
    self.messageTextView.layer.masksToBounds = YES;
    self.messageTextView.textContainerInset = UIEdgeInsetsMake(OYE_CHAT_MESSAGE_VERTICAL_INSET, OYE_CHAT_MESSAGE_HORIZONTAL_INSET, OYE_CHAT_MESSAGE_VERTICAL_INSET, OYE_CHAT_MESSAGE_HORIZONTAL_INSET);
}

@end

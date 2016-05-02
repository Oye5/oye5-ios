//
//  OYEChatMessage.h
//  Oye5
//
//  Created by Rita Kyauk on 4/24/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "MTSMotisObject.h"

typedef NS_ENUM(NSUInteger, OYEChatMessageType) {
    OYEChatMessageTypeInvalid,
    OYEChatMessageTypeIncoming,
    OYEChatMessageTypeOutgoing
};

@interface OYEChatMessage : MTSMotisObject

@property (assign, nonatomic) NSInteger type;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSDate *timestamp;

@end

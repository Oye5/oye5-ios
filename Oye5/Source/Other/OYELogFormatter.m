//
//  OYELogFormatter.m
//  Oye5
//
//  Created by Rita Kyauk on 2/28/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYELogFormatter.h"

@implementation OYELogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *logLevel;
    switch (logMessage->_flag) {
        case DDLogFlagError    : logLevel = @"E"; break;
        case DDLogFlagWarning  : logLevel = @"W"; break;
        case DDLogFlagInfo     : logLevel = @"I"; break;
        case DDLogFlagDebug    : logLevel = @"D"; break;
        default                : logLevel = @"V"; break;
    }
    
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSDate *utcDate = [NSDate date];
    NSInteger seconds = [tz secondsFromGMTForDate:utcDate];
    NSDate *date = [NSDate dateWithTimeInterval: seconds sinceDate:utcDate];

    return [NSString stringWithFormat:@"%@ | %@ | %@ Line %lu | %@\n", logLevel, date, logMessage.function, (unsigned long)logMessage.line, logMessage->_message];
}

@end

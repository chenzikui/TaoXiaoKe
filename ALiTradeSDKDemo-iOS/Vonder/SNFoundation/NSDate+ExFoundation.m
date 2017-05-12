//
//  NSDate+NSDate_ExFoundation.m
//  Giivv
//
//  Created by Xiong,Zijun on 16/5/1.
//  Copyright © 2016  Youdar . All rights reserved.
//

#import "NSDate+ExFoundation.h"

@implementation NSDate (ExFoundation)
#pragma makr - date fransfer
+ (NSDate *)dateWithDouble:(double) timeSpan{
    return [NSDate dateWithTimeIntervalSince1970: timeSpan / 1000.0f];
}

#pragma mark - tommorrow date
+ (NSDate *)tommorrow{
    return  [NSDate dateWithTimeIntervalSinceNow:24 * 60 * 60];
}

#pragma mark - date formate
- (NSString *)stringFormate:(NSString *) formation{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat: formation];
    return [dateFormater stringFromDate: self];
}

#pragma mark - timeStamp from date
- (NSNumber *)timeStamp{
//    NSLog(@"%@", [self stringFormate: @"yyyy-MM-dd"]);
    NSString *dateString = [self stringFormate: @"MM/dd/yyyy"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *utcDate = [dateFormatter dateFromString: dateString];
    return @((long long)[utcDate timeIntervalSince1970] * 1000);
}
@end

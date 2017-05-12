//
//  NSDate+SNFoundation.m
//  SNFoundation
//
//  Created by liukun on 14-3-4.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import "NSDate+SNFoundation.h"

@implementation NSDate (SNFoundation)

+ (NSDate *)getDate:(NSString *)dateStr pattern:(NSString *)ptn
{
    NSLocale *locale = [NSLocale currentLocale];
    
    return [self getDate:dateStr pattern:ptn locale:locale];
}

+ (NSDate *)getDate:(NSString *)sDate pattern:(NSString *)ptn locale:(NSLocale *)loc
{
    if (!sDate || !sDate.length)
    {
        return nil;
    }
    
    NSString *dateStr = sDate;
    
    NSDate *date = nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = ptn;
    dateFormatter.locale = loc;
    
    date = [dateFormatter dateFromString:dateStr];
    
    
//    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//    [outputFormatter setLocale:[NSLocale currentLocale]];
//    [outputFormatter setDateFormat:@"yyyy年MM月dd日 HH时mm分ss秒"];
//    NSString *str = [outputFormatter stringFromDate:date];
//    NSLog(@"datestr = %@",str);
    
    return date;
}


/**
 *  获取时差
 *
 *  @param timestamp
 *
 *  @return
 */
+ (int)intervalSinceNow: (NSDate *) timestamp
{
    //时差
    NSDate *dat = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:dat];
    
    NSDate *d = timestamp;
    d = [d  dateByAddingTimeInterval: interval];
    
    dat = [dat  dateByAddingTimeInterval: interval];
    NSTimeInterval aTime = [d timeIntervalSinceDate:dat];
    return (int)aTime;
}


+(NSString *)getNowDateFormat:(NSString*)format{
    NSDate *now = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:format];
    return [df stringFromDate:now];
}

@end

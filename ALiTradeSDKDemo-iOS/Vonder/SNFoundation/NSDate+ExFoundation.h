//
//  NSDate+NSDate_ExFoundation.h
//  Giivv
//
//  Created by Xiong,Zijun on 16/5/1.
//  Copyright © 2016  Youdar . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ExFoundation)
/**
 *  date fransfer
 *
 *  @param timeSpan value of timespan
 *
 *  @return tranfer date
 */
+ (NSDate *)dateWithDouble:(double) timeSpan;

/**
 *  tommorrow date
 *
 *  @return NSdate
 */
+ (NSDate *)tommorrow;

/**
 *  date formate
 *
 *  @param formation formate string
 *
 *  @return string after formate
 */
- (NSString *)stringFormate:(NSString *) formation;

/**
 *  timeStamp from date
 *
 *  @return timeStamp
 */
- (NSNumber *)timeStamp;
@end

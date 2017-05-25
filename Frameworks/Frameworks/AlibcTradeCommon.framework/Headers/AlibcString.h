/*
 * AlibcString.h 
 *
 * 阿里百川电商
 * 项目名称：阿里巴巴电商 AlibcTradeCommon 
 * 版本号：3.1.1.93
 * 发布时间：2017-03-06
 * 开发团队：阿里巴巴百川商业化团队
 * 阿里巴巴电商SDK答疑群号：1229144682(阿里旺旺)
 * Copyright (c) 2016-2019 阿里巴巴-移动事业群-百川. All rights reserved.
 */

#import <Foundation/Foundation.h>

#ifndef AlibcString_h
#define AlibcString_h

@interface AlibcString : NSObject

+ (BOOL)isChinaMobileNumber:(NSString *)number;

+ (NSString *)fromCString:(char *)cString;

+ (NSString *)fromNSData:(NSData *)data;

+ (NSString *)fromNSData:(NSData *)data encoding:(NSStringEncoding)encoding;

+ (NSString *)fromProtocol:(Protocol *)protocol;

+ (NSString *)fromObject:(id)obj;

+ (NSString *)fromClass:(Class)clazz;

+ (NSString *)fromSelector:(SEL)selector;

+ (const char *)toCString:(NSString *)string;

+ (NSData *)toNSData:(NSString *)string;

+ (Protocol *)toProtocol:(NSString *)string;

+ (Class)toClass:(NSString *)string;

+ (SEL)toSEL:(NSString *)string;

+ (NSString *)trim:(NSString *)string;

+ (BOOL)hasSubString:(NSString *)string substring:(NSString *)substring;

+ (BOOL)isBlank:(NSString *)string;

+ (BOOL)isNotBlank:(NSString *)string;

+ (NSArray *)split:(NSString *)string sep:(NSString *)sep;

@end

#endif

//
//  NSString+SNFoundation.h
//  SNFoundation
//
//  Created by liukun on 14-3-3.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SNFoundation)

- (NSString *)urlByAppendingDict:(NSDictionary *)params;
- (NSString *)urlByAppendingDictNoEncode:(NSDictionary *)params;

+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict addingPercentEscapes:(BOOL)add;
- (NSDictionary *)queryDictionaryUsingEncoding:(NSStringEncoding)encoding;

- (NSString *)URLEncoding;
- (NSString *)URLDecoding;

- (NSString *)trim;
- (BOOL)isEmpty;
- (BOOL)eq:(NSString *)other;

- (BOOL)isValueOf:(NSArray *)array;
- (BOOL)isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens;

- (NSString *)getterToSetter;
- (NSString *)setterToGetter;

- (NSString *)formatJSON;
+ (NSString *)GUIDString;
- (NSString *)removeHtmlTags;

- (BOOL)has4ByteChar;
- (BOOL)isAsciiString;
/**
 格式化金额
 @param number 金额
 @param i 小数位数
 @return
 */
+(NSString*)formatDecimal:(double)number cnt:(int)i;

-(BOOL)containsString:(NSString *)str;
/**
 *  获取NSString size
 *
 *  @param font 字体大小
 *  @param size 最大宽高
 *
 *  @return string 大小
 */
-(CGSize)textSizeWithFont:(UIFont*)font maxSize:(CGSize)size;


/**
 处理首行缩进 是字符串处理（主要解决Label 换行BUG）在字符串上加空格使Label换行正确
 @param lb_width Label宽度
 @param indent 缩进距离
 @param font 文字Font
 @return 返回带空格的字符串 开始空格位置为换行位置
 */
-(NSMutableString*)formatNameLabelWidth:(CGFloat)lb_width firstLineHeadIndent:(CGFloat)indent font:(UIFont*)font;
@end

#pragma mark -

@interface NSString (SNEncryption)

- (NSString *)MD5Hex;
- (NSData *)hexStringToData;    //从16进制的字符串格式转换为NSData

@end


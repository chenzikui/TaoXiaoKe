//
//  NSDictionary+SNFoundation.h
//  SNFoundation
//
//  Created by xj on 15/10/15.
//  Copyright (c) 2015年 xj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SNFoundation)

-(NSString *)EncodeStringFromDicWithKey:(NSString*) key;
-(NSNumber *)EncodeNumberFromDicWithKey:(NSString*) key;
-(NSDictionary *)EncodeDicFromDicWithKey:(NSString*) key;
-(NSArray *)EncodeArrayFromDicWithKey:(NSString*) key ;
-(NSArray *)EncodeArrayFromDicUsingParseBlockWithKey:(NSString*)key completion:(id(^)(NSDictionary *innerDic))parseBlock;
- (NSString *)toJSONData;
//+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSDictionary*)getObjectData:(id)obj Class:(Class)Class;
@end

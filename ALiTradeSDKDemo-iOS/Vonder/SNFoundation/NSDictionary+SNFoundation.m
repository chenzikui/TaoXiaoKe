//
//  NSDictionary+SNFoundation.m
//  SNFoundation
//
//  Created by xj on 15/10/15.
//  Copyright (c) 2015年 xj. All rights reserved.
//

#import "NSDictionary+SNFoundation.h"
#import <objc/runtime.h>
@implementation NSDictionary (SNFoundation)



-(NSString *)EncodeStringFromDicWithKey:(NSString*) key;
{
    id temp = [self objectForKey:key];
    if ([temp isKindOfClass:[NSString class]])
    {
        return temp;
    }
    else if ([temp isKindOfClass:[NSNumber class]])
    {
        return [temp stringValue];
    }
    return nil;
}

-(NSNumber *)EncodeNumberFromDicWithKey:(NSString*) key
{
    id temp = [self objectForKey:key];
    if ([temp isKindOfClass:[NSString class]])
    {
        return [NSNumber numberWithDouble:[temp doubleValue]];
    }
    else if ([temp isKindOfClass:[NSNumber class]])
    {
        return temp;
    }
    return nil;
}

-(NSDictionary *)EncodeDicFromDicWithKey:(NSString*) key
{
    id temp = [self objectForKey:key];
    if ([temp isKindOfClass:[NSDictionary class]])
    {
        return temp;
    }
    return nil;
}

-(NSArray *)EncodeArrayFromDicWithKey:(NSString*) key
{
    id temp = [self objectForKey:key];
    if ([temp isKindOfClass:[NSArray class]])
    {
        return temp;
    }
    return nil;
}

-(NSArray *)EncodeArrayFromDicUsingParseBlockWithKey:(NSString*)key completion:(id(^)(NSDictionary *innerDic))parseBlock
{
    NSArray *tempList = [self EncodeArrayFromDicWithKey:key];
    if ([tempList count])
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[tempList count]];
        for (NSDictionary *item in tempList)
        {
            id dto = parseBlock(item);
            if (dto)
            {
                [array addObject:dto];
            }
        }
        return array;
    }
    return nil;
}


- (NSString *)toJSONData{
    
    NSString *jsonString = @"";
    if(![NSJSONSerialization isValidJSONObject:self])
    {
        NSLog(@"不是JSON类型数据");
        return jsonString = @"不是JSON类型数据";
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if([jsonData length] > 0 && error == nil)
    {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    return jsonString = @"JSON转义失败";
}


- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


+ (NSDictionary*)getObjectData:(id)obj Class:(Class)Class
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList(Class, &propsCount);
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil)
        {
            value = [NSNull null];
        }
        else
        {
            value = [self getObjectInternal:value Class:Class];
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}

+ (id)getObjectInternal:(id)obj Class:(Class)Class
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i] Class:Class] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key] Class:Class] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj Class:Class];
}


@end

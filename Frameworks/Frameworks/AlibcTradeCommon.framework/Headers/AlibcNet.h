/*
 * AlibcNet.h 
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

#ifndef AlibcNet_h
#define AlibcNet_h

NS_ASSUME_NONNULL_BEGIN

@interface AlibcNet : NSObject

+ (void)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error))completionHandler;

+ (void)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END

#endif

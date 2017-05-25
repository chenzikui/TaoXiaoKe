/*
 * AlibcTradeTaokeParams.h 
 *
 * 阿里百川电商
 * 项目名称：阿里巴巴电商 AlibcTradeSDK 
 * 版本号：3.1.1.12
 * 发布时间：2016-11-23
 * 开发团队：阿里巴巴百川商业化团队
 * 阿里巴巴电商SDK答疑群号：1229144682(阿里旺旺)
 * Copyright (c) 2016-2019 阿里巴巴-移动事业群-百川. All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
 *  统一的 key 写法
 */
static NSString *const AlibcTradeTaokeParamsPID     = @"pid";
static NSString *const AlibcTradeTaokeParamsUNIONID = @"unionId";
static NSString *const AlibcTradeTaokeParamsSUBPID  = @"subpid";

/** 淘客参数 */
@interface AlibcTradeTaokeParams : NSObject
/** 淘客ID */
@property (nonatomic, copy) NSString *pid;
/** */
@property (nonatomic, copy) NSString *unionId;
/** */
@property (nonatomic, copy) NSString *subPid;

@end

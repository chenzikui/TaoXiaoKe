/*
 * ALiTradeSDK.h 
 *
 * 阿里百川电商
 * 项目名称：阿里巴巴电商 SDK
 * 开发团队：阿里巴巴百川商业化团队
 * 阿里巴巴电商SDK答疑群号：********
 * Copyright (c) 2015-2019 阿里巴巴-移动事业群-百川. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "ALiTradeTaokeParams.h"
#import "ALiTradeService.h"

#define ALiSDKVersion @"3.0.0.1"

#ifndef ALiService
#define ALiService(__protocol__) \
((id<__protocol__>)([[ALBBSDK sharedInstance] getService:@protocol(__protocol__)]))
#endif

/** 环境,测试和预发,只有内网有效,外部使用只能用线上环境 */
typedef NS_ENUM (NSUInteger, ALiEnvironment) {
    /** 未定义环境 */
    ALiEnvironmentNone = -1,
    /** 测试环境 */
    ALiEnvironmentDaily = 0,
    /** 预发环境 */
    ALiEnvironmentPreRelease,
    /** 线上环境 */
    ALiEnvironmentRelease
};


@interface ALiTradeSDK :NSObject

+ (instancetype)sharedInstance;

/**
初始化函数,请先调用触发后再调用其他接口 @param url
 @param appkey
 */
- (void)asyncInit:(NSString*)appKey success:(void (^)())onSuccess failure:(void (^)(NSError *error))onFailure;

//获取service
-(id<ALiTradeService>)tradeService;

/**
 用于处理其他App的回跳
 @param url
 @return 是否经过了SDK的处理
 */
- (BOOL)handleOpenURL:(NSURL *)url;

//获取本地log文件路径,排查用
- (NSString*)getLogFilePath;
@end


@interface ALiTradeSDK (Settings)

- (void)setDebugLogOpen:(BOOL)isDebugLogOpen;

/**
 设置环境
 */
- (void)setEnv:(ALiEnvironment)env;
- (ALiEnvironment)getEnv;


/**
 设置全局配置，是否强制使用h5
 @param isForceH5
 */
- (void)setIsForceH5:(BOOL)isForceH5;

/*
 * 设置是否使用同步打点
 */
- (void)setIsSyncForTaoke:(BOOL)isSync;

//设置三方app版本
- (void)setIsvVersion:(NSString*)version;



/**
 app标识，和isvcode同义，用来追踪订单
 @param tag tag description
 */
- (void)setISVCode:(NSString *)tag;

/*设置默认淘客参数*/
- (void)setTaokeParams:(ALiTradeTaokeParams*)param;

/**
 设置渠道信息,渠道专享价专用.包含渠道类型和渠道名
 */
- (void)setChannel:(NSString *)type name:(NSString *)name;


@end
/*
 * ALiTradeShowParams.h 
 *
 * 阿里百川电商
 * 项目名称：阿里巴巴电商 SDK
 * 开发团队：阿里巴巴百川商业化团队
 * 阿里巴巴电商SDK答疑群号：********
 * Copyright (c) 2015-2019 阿里巴巴-移动事业群-百川. All rights reserved.
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, ALiOpenType) {
    ALiOpenTypeAuto,   //智能判断
    ALiOpenTypeNative,  //强制跳手淘
    ALiOpenTypeH5       //强制h5展示
} ;

@interface ALiTradeShowParams : NSObject
//若为NO, 则在当前view controller上present新页面; 否则在传入的UINavigationController上push新页面.
@property(nonatomic,assign) BOOL isNeedPush;        //默认值:NO,传入自定义webview时无效
@property(nonatomic,assign) ALiOpenType openType;   //默认值:Auto
@property(nonatomic,strong) NSString *backUrl;      //指定手淘回跳的地址，跳转至isv指定的url，规则：tbopen${appkey}://xx.xx.xx

@end

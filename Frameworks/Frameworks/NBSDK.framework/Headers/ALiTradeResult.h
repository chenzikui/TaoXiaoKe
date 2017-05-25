/*
 * ALiTradeResult.h 
 *
 * 阿里百川电商
 * 项目名称：阿里巴巴电商 SDK
 * 开发团队：阿里巴巴百川商业化团队
 * 阿里巴巴电商SDK答疑群号：********
 * Copyright (c) 2015-2019 阿里巴巴-移动事业群-百川. All rights reserved.
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, ALiTradeResultType) {
    ALiTradeResultTypeAddCard,   //成功添加到购物车
    ALiTradeResultTypePaySuccess  //成功支付
} ;


/** 支付结果 */
@interface ALiPayResult : NSObject
/** 支付成功订单 */
@property (nonatomic, copy, nullable, readonly) NSArray *paySuccessOrders;
/** 支付失败订单 */
@property (nonatomic, copy, nullable, readonly) NSArray *payFailedOrders;
@end

/** 交易结果 */
@interface ALiTradeResult : NSObject
@property (nonatomic, assign) ALiTradeResultType result;
/** 支付结果,只有Result为 ALiTradeResultTypePaySuccess时有效*/
@property (nonatomic, strong, nullable) ALiPayResult *payResult;
@end




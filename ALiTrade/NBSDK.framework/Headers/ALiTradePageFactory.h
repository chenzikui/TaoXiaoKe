/*
 * ALiTradePageFactory.h 
 *
 * 阿里百川电商
 * 项目名称：阿里巴巴电商 SDK
 * 开发团队：阿里巴巴百川商业化团队
 * 阿里巴巴电商SDK答疑群号：********
 * Copyright (c) 2015-2019 阿里巴巴-移动事业群-百川. All rights reserved.
 */

#import <Foundation/Foundation.h>


@protocol ALiTradePage <NSObject>

@end


NS_ASSUME_NONNULL_BEGIN

/** 页面工厂类 */
@interface ALiTradePageFactory : NSObject

/**
 创建URL指定页面
 @param url     地址
 @return URL指定页面
 */
+ (id<ALiTradePage>)page:(NSString *)url;

/**
 创建商品真实ID或者混淆(open)ID对应的详情页面
 @param itemId   商品真实ID或者混淆(open)ID
 @return 详情页面
 */
+ (id<ALiTradePage>)itemDetailPage:(NSString *)itemId;

/**
 创建我的购物车页面
 @return 我的购物车页面
 */
+ (id<ALiTradePage>)myCartsPage;

/**
 创建我的订单列表页面
 @param status      订单状态. 0为全部订单; 1为待付款订单; 2为待发货订单; 3为待收货订单; 4为待评价订单.
 @param isAllOrder  是否显示全部订单. 传YES时, 显示全部订单; 传NO时, 显示ISV的订单.
 @return 我的订单列表页面
 */
+ (id<ALiTradePage>)myOrdersPage:(NSInteger)status isAllOrder:(BOOL)isAllOrder;

/**
 *  创建店铺页面
 *
 *  @param shopId 店铺ID
 *
 *  @return 店铺页面
 */
+ (id<ALiTradePage>)shopPage:(NSString *)shopId ;

/**
 *  创建添加到购物车页面
 *
 @param itemId   商品真实ID或者混淆(open)ID
 *
 *  @return 店铺页面
 */
+ (id<ALiTradePage>)addCartPage:(NSString *)itemId;

@end

NS_ASSUME_NONNULL_END


//
//  TXKHomeRecommendationGoodsModel.h
//  ALiTradeSDKDemo-iOS
//
//  Created by 陈自奎 on 17/5/24.
//  Copyright © 2017年 com.alibaba-inc.taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXKHomeRecommendationGoodsModel : NSObject

@property(nonatomic,copy)NSString *good_id;//商品id
@property(nonatomic,copy)NSString *good_name;//商品名称
@property(nonatomic,copy)NSString *good_picture;//商品主图
@property(nonatomic,copy)NSString *good_detailurl;//商品详情页链接地址
@property(nonatomic,copy)NSString *shop_name;//店铺名称
@property(nonatomic,copy)NSString *good_price;//商品价格(单位：元)
@property(nonatomic,copy)NSString *good_saleNum;//商品月销量
@property(nonatomic,copy)NSString *yongjin_scale;//收入比率(%)
@property(nonatomic,copy)NSString *yongjin_price;//佣金
@property(nonatomic,copy)NSString *shoper_name;//卖家旺旺
@property(nonatomic,copy)NSString *tbk_shorturl;//淘宝客短链接(300天内有效)
@property(nonatomic,copy)NSString *tbk_longurl;//淘宝客链接
@property(nonatomic,copy)NSString *tbk_koulin;//淘口令(300天内有效)
@property(nonatomic,copy)NSString *juan_allNum;//优惠券总量
@property(nonatomic,copy)NSString *juan_surplusNum;//优惠券剩余量
@property(nonatomic,copy)NSString *juan_price;//优惠券面额
@property(nonatomic,copy)NSString *juan_startTime;//优惠券开始时间
@property(nonatomic,copy)NSString *juan_endTime;//优惠券结束时间
@property(nonatomic,copy)NSString *juan_longurl;//优惠券链接
@property(nonatomic,copy)NSString *juan_koulin;//优惠券淘口令(300天内有效)
@property(nonatomic,copy)NSString *juan_shorturl;//优惠券短链接(300天内有效)
@property(nonatomic,copy)NSString *isMarketingPlan;//是否为营销计划商品

-(void)setupModelWithDic:(NSDictionary *)dic;

@end

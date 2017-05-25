//
//  TXKHomeRecommendationGoodsModel.m
//  ALiTradeSDKDemo-iOS
//
//  Created by 陈自奎 on 17/5/24.
//  Copyright © 2017年 com.alibaba-inc.taobao. All rights reserved.
//

#import "TXKHomeRecommendationGoodsModel.h"

@implementation TXKHomeRecommendationGoodsModel
-(void)setupModelWithDic:(NSDictionary *)dic{

    self.good_id=[dic EncodeStringFromDicWithKey:@"商品id"];
    self.good_name=[dic EncodeStringFromDicWithKey:@"商品名称"];
    self.good_picture=[dic EncodeStringFromDicWithKey:@"商品主图"];
    self.good_detailurl=[dic EncodeStringFromDicWithKey:@"商品详情页链接地址"];
    self.shop_name=[dic EncodeStringFromDicWithKey:@"店铺名称"];
    self.good_price=[dic EncodeStringFromDicWithKey:@"商品价格(单位：元)"];
    self.good_saleNum=[dic EncodeStringFromDicWithKey:@"商品月销量"];
    self.yongjin_scale=[dic EncodeStringFromDicWithKey:@"收入比率(%)"];
    self.yongjin_price=[dic EncodeStringFromDicWithKey:@"佣金"];
    self.shoper_name=[dic EncodeStringFromDicWithKey:@"卖家旺旺"];
    self.tbk_shorturl=[dic EncodeStringFromDicWithKey:@"淘宝客短链接(300天内有效)"];
    self.tbk_longurl=[dic EncodeStringFromDicWithKey:@"淘宝客链接"];
    self.tbk_koulin=[dic EncodeStringFromDicWithKey:@"淘口令(300天内有效)"];
    self.juan_allNum=[dic EncodeStringFromDicWithKey:@"优惠券总量"];
    self.juan_surplusNum=[dic EncodeStringFromDicWithKey:@"优惠券剩余量"];
    self.juan_price=[dic EncodeStringFromDicWithKey:@"优惠券面额"];
    self.juan_startTime=[dic EncodeStringFromDicWithKey:@"优惠券开始时间"];
    self.juan_endTime=[dic EncodeStringFromDicWithKey:@"优惠券结束时间"];
    self.juan_longurl=[dic EncodeStringFromDicWithKey:@"优惠券链接"];
    self.juan_koulin=[dic EncodeStringFromDicWithKey:@"优惠券淘口令(300天内有效)"];
    self.juan_shorturl=[dic EncodeStringFromDicWithKey:@"优惠券短链接(300天内有效)"];
    self.isMarketingPlan=[dic EncodeStringFromDicWithKey:@"是否为营销计划商品"];
}

@end

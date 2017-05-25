//
//  TXKHomeShowItemView.h
//  ALiTradeSDKDemo-iOS
//
//  Created by 陈自奎 on 17/5/24.
//  Copyright © 2017年 com.alibaba-inc.taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXKHomeRecommendationGoodsModel.h"

@interface TXKHomeShowItemView : UIView

@property(nonatomic,strong)UIImageView *goodpic_vi;
@property(nonatomic,strong)UILabel *title_lb;
@property(nonatomic,strong)UILabel *shopname_lb;
@property(nonatomic,strong)UILabel *juanprice_lb;
@property(nonatomic,strong)UILabel *goodprice_lb;
@property(nonatomic,strong)UIImageView *juanimg_vi;
@property(nonatomic,strong)UILabel *saleNum_lb;


-(void)setupViewWithData:(TXKHomeRecommendationGoodsModel *)model;

@end

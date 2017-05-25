//
//  TXKHomeShowItemView.m
//  ALiTradeSDKDemo-iOS
//
//  Created by 陈自奎 on 17/5/24.
//  Copyright © 2017年 com.alibaba-inc.taobao. All rights reserved.
//

#import "TXKHomeShowItemView.h"

@interface TXKHomeShowItemView ()

@property(nonatomic,strong)UILabel *mark_lb;

@end

@implementation TXKHomeShowItemView

-(instancetype)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    if (self) {
        
        [self setupMySubviews];
    }
    return self;
}

-(void)setupMySubviews{

    self.backgroundColor=[UIColor whiteColor];
    
    self.goodpic_vi=[[UIImageView alloc]init];
    [self addSubview:self.goodpic_vi];
    
    self.title_lb=[UILabel new];
    self.title_lb.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.title_lb];
    
    self.shopname_lb=[UILabel new];;
    self.shopname_lb.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.shopname_lb];
    
    self.juanimg_vi=[UIImageView new];
    self.juanimg_vi.image=[UIImage imageNamed:@"优惠劵"];
    [self addSubview:self.juanimg_vi];
    
    self.juanprice_lb=[UILabel new];
    self.juanprice_lb.font=[UIFont systemFontOfSize:13];
    [self addSubview:self.juanprice_lb];
    
    self.goodprice_lb=[UILabel new];
    self.goodprice_lb.font=[UIFont systemFontOfSize:14];
    self.goodprice_lb.textColor=MainColor;
    [self addSubview:self.goodprice_lb];
    
    self.saleNum_lb=[UILabel new];
    self.saleNum_lb.font=[UIFont systemFontOfSize:12];
    self.saleNum_lb.textColor=[UIColor grayColor];
    [self addSubview:self.saleNum_lb];
    
    self.mark_lb=[UILabel new];
    self.mark_lb.font=[UIFont systemFontOfSize:13];
    self.mark_lb.textColor=[UIColor whiteColor];
    self.mark_lb.backgroundColor=MainColor;
    self.mark_lb.layer.masksToBounds=YES;
    self.mark_lb.layer.cornerRadius=3;
    self.mark_lb.frame=CGRectMake(0, 0, 33, 15);
    self.mark_lb.textAlignment=NSTextAlignmentCenter;
    [self.title_lb addSubview:self.mark_lb];
    
    
}

-(void)setupViewWithData:(TXKHomeRecommendationGoodsModel *)model{

    
    [self.goodpic_vi sd_setImageWithURL:[NSURL URLWithString:model.good_picture] placeholderImage:PlaceholderItemImage];
    self.goodpic_vi.sd_layout.leftSpaceToView(self,0).topSpaceToView(self,0).rightSpaceToView(self,0).heightIs(self.width);
    
    
    self.mark_lb.text=@"推荐";
    self.title_lb.text=[NSString stringWithFormat:@"          %@",model.good_name];
    self.title_lb.sd_layout.leftSpaceToView(self,10).rightSpaceToView(self,10).topSpaceToView(self.goodpic_vi,10).autoHeightRatio(0);
    
    if (![model.juan_price isEqualToString:@"无"]) {
        self.juanimg_vi.hidden=NO;
        self.juanprice_lb.hidden=NO;
        self.juanimg_vi.sd_layout.leftSpaceToView(self,10).topSpaceToView(self.title_lb,5).heightIs(20).widthIs(20);
        self.juanprice_lb.text=model.juan_price;
        self.juanprice_lb.sd_layout.leftSpaceToView(self.juanimg_vi,5).rightSpaceToView(self,10).topEqualToView(self.juanimg_vi).heightIs(20);
        
        self.goodprice_lb.text=[NSString stringWithFormat:@"¥%@",model.good_price];
        self.goodprice_lb.sd_layout.leftSpaceToView(self,10).topSpaceToView(self.juanprice_lb,5).heightIs(20);
        [self.goodprice_lb setSingleLineAutoResizeWithMaxWidth:100.0f];
        

        
    }else{
        self.juanimg_vi.hidden=YES;
        self.juanprice_lb.hidden=YES;
        
        self.goodprice_lb.text=[NSString stringWithFormat:@"¥%@",model.good_price];
        self.goodprice_lb.sd_layout.leftSpaceToView(self,10).topSpaceToView(self.title_lb,5).heightIs(20);
        [self.goodprice_lb setSingleLineAutoResizeWithMaxWidth:100.0f];
        
    }
    
    self.saleNum_lb.text=[NSString stringWithFormat:@"%@人付款",model.good_saleNum];
    self.saleNum_lb.sd_layout.leftSpaceToView(self.goodprice_lb,15).topEqualToView(self.goodprice_lb).rightSpaceToView(self,10).heightIs(20);
    

    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    NSLog(@"%f",self.left);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat max_y=self.saleNum_lb.bottom;
    
    self.frame=CGRectMake(self.left, self.top, self.width, max_y+10);
}

@end

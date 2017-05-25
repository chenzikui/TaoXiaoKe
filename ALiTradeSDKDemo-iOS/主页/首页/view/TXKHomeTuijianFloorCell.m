//
//  TXKHomeTuijianFloorCell.m
//  ALiTradeSDKDemo-iOS
//
//  Created by 陈自奎 on 17/5/24.
//  Copyright © 2017年 com.alibaba-inc.taobao. All rights reserved.
//

#import "TXKHomeTuijianFloorCell.h"

@implementation TXKHomeTuijianFloorCell

-(void)setupCellWithArray:(NSArray *)model_arr{

    self.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    TXKHomeShowItemView *last_vi_left;
    TXKHomeShowItemView *last_vi_right;
    TXKHomeShowItemView *last_vi;

    CGFloat item_w=ScreenW/2-5;
    for (int i=0; i<model_arr.count; i++) {
        
        if (i==0) {
            TXKHomeRecommendationGoodsModel *model=model_arr[i];
            TXKHomeShowItemView *item_vi=[[TXKHomeShowItemView alloc]initWithFrame:CGRectMake(0, 0, item_w, 200)];
            [item_vi setupViewWithData:model];
            [self.contentView addSubview:item_vi];
            last_vi_left = item_vi;
        }else if (i==1){
            TXKHomeRecommendationGoodsModel *model=model_arr[i];
            TXKHomeShowItemView *item_vi=[[TXKHomeShowItemView alloc]initWithFrame:CGRectMake(ScreenW/2+5, 0, item_w, 200)];
            [item_vi setupViewWithData:model];
            [self.contentView addSubview:item_vi];
            last_vi_right=item_vi;
        }else{
        
            last_vi=last_vi_left.bottom<last_vi_right.bottom?last_vi_left:last_vi_right;
            TXKHomeRecommendationGoodsModel *model=model_arr[i];
            TXKHomeShowItemView *item_vi=[[TXKHomeShowItemView alloc]initWithFrame:CGRectMake(last_vi.left, last_vi.bottom+5, item_w, 200)];
            [item_vi setupViewWithData:model];
            [self.contentView addSubview:item_vi];
            if (item_vi.left==0) {
                last_vi_left=item_vi;
            }else{
                last_vi_right=item_vi;
            }
         }
      }
    last_vi=last_vi_left.bottom>=last_vi_right.bottom?last_vi_left:last_vi_right;
    [self setupAutoHeightWithBottomView:last_vi bottomMargin:10];
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

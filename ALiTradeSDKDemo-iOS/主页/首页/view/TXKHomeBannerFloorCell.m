//
//  TXKHomeFloorTableViewCell.m
//  ALiTradeSDKDemo-iOS
//
//  Created by 陈自奎 on 17/5/23.
//  Copyright © 2017年 com.alibaba-inc.taobao. All rights reserved.
//

#import "TXKHomeBannerFloorCell.h"
#import "TXKADBannerView.h"

@implementation TXKHomeBannerFloorCell


-(void)setupCellWithDTO:(TXKFloorDTO *)model with:(NSIndexPath *)indexpath{

    TXKADBannerView *banner=[[TXKADBannerView alloc]initWithFrame:CGRectMake(0, 0, Width,custom_H+20)];
    [self addSubview:banner];

    
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

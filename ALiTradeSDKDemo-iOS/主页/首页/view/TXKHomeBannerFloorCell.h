//
//  TXKHomeFloorTableViewCell.h
//  ALiTradeSDKDemo-iOS
//
//  Created by 陈自奎 on 17/5/23.
//  Copyright © 2017年 com.alibaba-inc.taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXKFloorDTO.h"
@interface TXKHomeBannerFloorCell : UITableViewCell

-(void)setupCellWithDTO:(TXKFloorDTO *)model with:(NSIndexPath *)indexpath;

@end

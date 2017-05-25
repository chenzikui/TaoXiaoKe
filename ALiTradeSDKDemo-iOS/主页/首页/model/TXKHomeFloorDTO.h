//
//  TXKHomeFloorDTO.h
//  ALiTradeSDKDemo-iOS
//
//  Created by 陈自奎 on 17/5/23.
//  Copyright © 2017年 com.alibaba-inc.taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TXKFloorDTO.h"

@interface TXKHomeFloorDTO : NSObject

@property(nonatomic,strong)NSMutableArray *floor_arr;


-(void)setupFloorDatas;

@end

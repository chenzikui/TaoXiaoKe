//
//  TXKHomeFloorDTO.m
//  ALiTradeSDKDemo-iOS
//
//  Created by 陈自奎 on 17/5/23.
//  Copyright © 2017年 com.alibaba-inc.taobao. All rights reserved.
//

#import "TXKHomeFloorDTO.h"
#import "TXKHomeRecommendationGoodsModel.h"

@implementation TXKHomeFloorDTO

-(NSMutableArray *)floor_arr{

    if (!_floor_arr) {
        _floor_arr=[[NSMutableArray alloc]init];
    }
    return _floor_arr;
}

-(void)setupFloorDatas{
    
    [self addBannerFloor];
    [self addTuijianFloor];
}


-(void)addBannerFloor{

    TXKFloorDTO *floor=[[TXKFloorDTO alloc]init];
    floor.templateID=@"1";
    floor.height=170.0f;
    floor.floors=1;
    floor.sectionHeight=CGFLOAT_MIN;
    [self.floor_arr addObject:floor];
}
-(void)addTuijianFloor{

    TXKFloorDTO *floor=[[TXKFloorDTO alloc]init];
    floor.templateID=@"4";
    floor.height=-1;
    floor.floors=1;
    floor.moduleList=[self setupRecommendationGoods];
    floor.sectionHeight=40.0f;
    [self.floor_arr addObject:floor];

}
//获取推荐商品
-(NSMutableArray *)setupRecommendationGoods{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"推荐商品" ofType:@"txt"];
    NSString *fileContents = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF16StringEncoding error:nil];
    //首先取出每一行的数据
    NSArray *tuijian_lines = [fileContents componentsSeparatedByString:@"\r\n"];
    
    if (!tuijian_lines) {
        return nil;
    }
    NSString *titles=[tuijian_lines firstObject];
    NSArray *title_arr=[titles componentsSeparatedByString:@"\t"];
    NSMutableDictionary *recommendation_dic=[NSMutableDictionary new];

    NSMutableArray *model_arr=[NSMutableArray new];
    for (int i=1; i<tuijian_lines.count; i++) {
        NSString *content=tuijian_lines[i];
        NSArray *goods_arrs = [content componentsSeparatedByString:@"\t"];
        
        for (int j=0; j<goods_arrs.count; j++) {
            NSString *key_str=title_arr[j];
            NSString *vaule_str=goods_arrs[j];
            [recommendation_dic setObject:vaule_str forKey:key_str];
        }
        TXKHomeRecommendationGoodsModel *model = [[TXKHomeRecommendationGoodsModel alloc]init];
        [model setupModelWithDic:recommendation_dic];
        [model_arr addObject:model];
    }
    
    
    return model_arr;
}


@end

//
//  HomeFloorDTO.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/14.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//  首页楼层DTO

#import <objc/message.h>

@interface TXKFloorDTO : NSObject

//楼层序号
@property (nonatomic, copy) NSString    *orderNO;

//楼层名称(楼层的实际名称是其第一个模块名称)
@property (nonatomic, copy) NSString    *floorName;

//楼层颜色
@property (nonatomic, strong) UIColor  *color;

//显示楼层头
@property (nonatomic, assign) BOOL is_showHeade;

//显示楼层底
@property (nonatomic, assign) BOOL is_showFoote;

//显示跳转按钮
@property (nonatomic, assign) BOOL is_jumpBtn;

//模板ID
@property (nonatomic, copy) NSString    *templateID;

//楼层层数
@property (nonatomic, assign) NSInteger floors;

//楼层层高
@property (nonatomic, assign) CGFloat height;

//楼层间隔
@property (nonatomic, assign) CGFloat sectionHeight;

//模块列表
@property (nonatomic, strong) NSMutableArray   *moduleList;
@end

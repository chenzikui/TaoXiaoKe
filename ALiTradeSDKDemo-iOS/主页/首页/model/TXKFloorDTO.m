//
//  HomeFloorDTO.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/14.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "TXKFloorDTO.h"

@implementation TXKFloorDTO


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.moduleList = [[NSMutableArray alloc] init];
        _sectionHeight = 0.0f;
    }
    return self;
}

@end

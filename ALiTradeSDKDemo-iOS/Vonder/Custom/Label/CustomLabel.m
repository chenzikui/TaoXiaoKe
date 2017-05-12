//
//  CustomLabel.m
//  MyAppFrame
//
//  Created by 陈自奎 on 17/4/7.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

-(instancetype)initLabelWithStyle:(CustomLabel_Style)style{

    self=[super init];
    if (self) {
        [self setupLabelWtihStyle:style];
    }
    return self;
}

-(void)setupLabelWtihStyle:(CustomLabel_Style)style{

    switch (style) {
        case CustomLabel_StyleValue1:
        {
            self.font=[UIFont systemFontOfSize:15];
            self.textColor=[UIColor blackColor];
        }
            break;
        case CustomLabel_StyleValue2:
        {
            self.font=[UIFont systemFontOfSize:13];
            self.textColor=[UIColor grayColor];
        }
            break;
        default:
            break;
    }
}

@end

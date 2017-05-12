//
//  UIView+IBAppearance.m
//  ALiTradeSDKDemo-iOS
//
//  Created by Veight Zhou on 16/7/6.
//  Copyright © 2016年 com.alibaba-inc.taobao. All rights reserved.
//

#import "UIView+IBAppearance.h"

@implementation UIView (IBAppearance)

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = [borderColor CGColor];
}

@end

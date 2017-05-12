//
//  UIView+Extension.h
//  导航标题按钮
//
//  Created by DFSJ on 2017/4/6.
//  Copyright © 2017年 dfsj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic ,assign) CGFloat x;
@property (nonatomic ,assign) CGFloat y;
@property (nonatomic ,assign) CGFloat width;
@property (nonatomic ,assign) CGFloat height;
@property (nonatomic ,assign) CGFloat centerX;
@property (nonatomic ,assign) CGFloat centerY;
@property (nonatomic ,assign) CGSize size;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

+ (instancetype)PW_viewFromXib;

@end

//
//  CustomLabel.h
//  MyAppFrame
//
//  Created by 陈自奎 on 17/4/7.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CustomLabel_StyleValue1 = 0, ///(默认)带色背景，白色字体, 不带圆角；(点击)背景加深
    CustomLabel_StyleValue2 = 1, ///(默认)透明背景，黑色字体，黑色边框, 带圆角 ,(点击)带色字体，带色边框
    CustomLabel_StyleValue3 = 2, ///(默认)带色背景，白色字体, 带圆角；(点击)背景变深，白色字体，带色边框
    CustomLabel_StyleValue4 = 3, ///(默认)透明背景，带色字体，带色边框, 带圆角；(点击)暂无
    CustomLabel_StyleValue5 = 4, ///(默认)透明背景，白色字体，白色边框, 带圆角；(点击)暂无
    CustomLabel_StyleValue6 = 5, ///(默认)单位按钮,带背景图
    CustomLabel_StyleValue7 = 6, ///(默认)单位按钮,带背景图
    CustomLabel_StyleValue8 = 7, ///(默认)灰色背景，不带圆角，黑色字体
    /*
     ......
     */
}CustomLabel_Style;

@interface CustomLabel : UILabel

-(instancetype)initLabelWithStyle:(CustomLabel_Style)style;


@end

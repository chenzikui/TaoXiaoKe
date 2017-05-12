//
//  PWSegmentedBottomView.m
//  导航标题按钮
//
//  Created by DFSJ on 2017/4/6.
//  Copyright © 2017年 dfsj. All rights reserved.
//

#import "PWSegmentedBottomView.h"

@implementation PWSegmentedBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        // 开启分页
        self.pagingEnabled = YES;
        // 没有弹簧效果
        self.bounces = NO;
        // 隐藏水平滚动条
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

/**
 *  给外界提供的方法（必须实现）
 *  @param index    外界控制器子控制器View的下表
 *  @param outsideVC    外界控制器（主控制器、self的父控制器）
 */
- (void)showChildVCViewWithIndex:(NSInteger)index outsideVC:(UIViewController *)outsideVC {
    
    CGFloat offsetX = index * self.frame.size.width;
    
    UIViewController *vc = outsideVC.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self addSubview:vc.view];
    
    vc.view.frame = CGRectMake(offsetX, 0, self.frame.size.width , self.frame.size.height);
}


- (void)setChildViewController:(NSArray *)childViewController {
    _childViewController = childViewController;
    
    self.contentSize = CGSizeMake(self.frame.size.width * childViewController.count, 0);
}
@end

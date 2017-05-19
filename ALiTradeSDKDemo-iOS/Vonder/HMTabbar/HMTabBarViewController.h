//
//  HMTabBarViewController.h
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LeftSlideViewController.h"


@interface HMTabBarViewController : UITabBarController

@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;


- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end

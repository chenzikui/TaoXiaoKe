//
//  PW_RollingScrollView.h
//  导航标题按钮
//
//  Created by DFSJ on 2017/4/6.
//  Copyright © 2017年 dfsj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PW_RollingScrollView;

@protocol PW_RollingScrollViewDelegate <NSObject>
// delegate 方法
- (void)SGSegmentedControlDefault:(PW_RollingScrollView *)segmentedControlDefault didSelectTitleAtIndex:(NSInteger)index;

@end


@interface PW_RollingScrollView : UIScrollView

@property (nonatomic, weak) id<PW_RollingScrollViewDelegate> delegate_PW;
/** 存入所有标题按钮 */
@property (nonatomic, strong) NSMutableArray *storageAlltitleBtn_mArr;

+ (instancetype)segmentedControlWithFrame:(CGRect)frame delegate:(id<PW_RollingScrollViewDelegate>)delegate childVcTitle:(NSArray *)childVcTitle isScaleText:(BOOL)isScaleText;

- (void)changeThePositionOfTheSelectedBtnWithScrollView:(UIScrollView *)scrollView;

#pragma mark - - - 激活按钮
- (void)buttonActive:(UIButton *)sender;

#pragma mark - - - 点击按钮
- (void)buttonAction:(UIButton *)sender;

@end

//
//  PWSegmentedView.h
//  导航标题按钮
//
//  Created by DFSJ on 2017/4/6.
//  Copyright © 2017年 dfsj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PWSegmentedView;

@protocol PWSegmentedViewDelegate <NSObject>
// delegate 方法
- (void)SGSegmentedControlStatic:(PWSegmentedView *)PWSegmentedViewStatic didSelectTitleAtIndex:(NSInteger)index;

@end


@interface PWSegmentedView : UIScrollView


@property (nonatomic, weak) id<PWSegmentedViewDelegate> PW_delegate;

/** 存入所有标题按钮 */
@property (nonatomic, strong) NSMutableArray *storageAlltitleBtn_mArr;

+ (instancetype)segmentedControlWithFrame:(CGRect)frame delegate:(id<PWSegmentedViewDelegate>)delegate childVcTitle:(NSArray *)childVcTitle;

- (void)changeThePositionOfTheSelectedBtnWithScrollView:(UIScrollView *)scrollView;

@end

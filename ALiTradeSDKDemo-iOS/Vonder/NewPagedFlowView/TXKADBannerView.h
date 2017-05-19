//
//  TXKADBannerView.h
//  NewPagedFlowViewDemo
//
//  Created by 陈自奎 on 17/5/19.
//  Copyright © 2017年 robertcell.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"

#define Width [UIScreen mainScreen].bounds.size.width

@protocol TXKADBannerViewDelegate <NSObject>

@optional

-(void)didSelectBannerCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex;

@end


@interface TXKADBannerView : UIView<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;


/**
 *  轮播图
 */
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;


/**
 *  代理
 */
@property (nonatomic, weak) id<TXKADBannerViewDelegate> delegate;

@end

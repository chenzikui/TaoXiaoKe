//
//  PersonalHomeController.h
//  DailyRanking
//
//  Created by ymy on 15/11/12.
//  Copyright © 2015年 com.xianlaohu.multipeer. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomNavHeadViewDelegate <NSObject>
@optional
- (void)NavHeadToLeft:(UIButton *)sender;
- (void)NavHeadToRight:(UIButton *)sender;
@end
@interface CustomNavHeadView : UIView
@property(nonatomic,assign)id<CustomNavHeadViewDelegate>delegate;
@property(nonatomic,strong)UIImageView * headBgView;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)UIColor * titleColor;
@property(nonatomic,strong)NSString * leftTitleImage;
@property(nonatomic,strong)NSString * rightTitleImage;

@property(nonatomic,strong)UILabel *title_lb;
@property(nonatomic,strong)UIButton * leftBtn;
@property(nonatomic,strong)UIButton * rightBtn;

-(void)setupViewWithLayer:(UIView *)sender;

@end

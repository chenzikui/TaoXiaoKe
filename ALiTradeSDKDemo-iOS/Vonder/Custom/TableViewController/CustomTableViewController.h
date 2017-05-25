//
//  CustomTableViewController.h
//  ALiTradeSDKDemo-iOS
//
//  Created by 陈自奎 on 17/5/16.
//  Copyright © 2017年 com.alibaba-inc.taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableView.h"
#import "CustomNavHeadView.h"

@interface CustomTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)CustomTableView *tableView;
@property(nonatomic,strong)CustomNavHeadView *navigation_vi;


//点击了导航栏左边按钮
-(void)didClickNavLeftButton:(UIButton *)sender;

//点击了导航栏右边按钮
-(void)didClickNavRightButton:(UIButton *)sender;



-(void)showbackButton;

-(void)showUserButtonOnLeft:(BOOL) isLeft withUserImageUrl:(NSString *)img_url;


@end

//
//  WLWebController.h
//  WangliBank
//
//  Created by 王启镰 on 16/6/21.
//  Copyright © 2016年 iSoftstone infomation Technology (Group) Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomWebProgressLayer.h"
#import "UIView+Frame.h"

@interface CustomWebController : UIViewController<UIWebViewDelegate>

@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) CustomWebProgressLayer *progressLayer; ///< 网页加载进度条;
@property (nonatomic, strong)UIView *customNavigationView;

-(void)setupUI;

@end

//
//  TXKHomeViewController.m
//  ALiTradeSDKDemo-iOS
//
//  Created by 陈自奎 on 17/5/12.
//  Copyright © 2017年 com.alibaba-inc.taobao. All rights reserved.
//

#import "TXKHomeViewController.h"
#import <ALBBSDK/ALBBWebViewService.h>
#import <ALBBLoginSDK/ALBBLoginService.h>
#import <ALBBSDK/ALBBSDK.h>
#import "UIButton+WebCache.h"
#import "HMTabBarViewController.h"
#import "TXKUserCenterViewController.h"

@interface TXKHomeViewController ()<LeftSlideViewControllerDelegate>{

    TaeSession *_session;
    HMTabBarViewController *_tabar;
}


@end

@implementation TXKHomeViewController

#pragma mark - setting



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    _session=[TaeSession sharedInstance];
    _tabar=(HMTabBarViewController *)self.tabBarController;
    _tabar.LeftSlideVC.delegate=self;
    
    self.navigation_vi.title=@"主页";
    

    
    [self StateChangedHandle];
    
    [self showUserButtonOnLeft:YES withUserImageUrl:[_session getUser].iconUrl];

    
}

-(void)viewWillAppear:(BOOL)animated{
    if ([_session isLogin]) {
        [_tabar.LeftSlideVC setPanEnabled:YES];
        [(TXKUserCenterViewController *)_tabar.LeftSlideVC.leftVC setupSubviewsData];

    }else{
        [_tabar.LeftSlideVC setPanEnabled:NO];
    }
}

-(void)viewWillDisappear:(BOOL)animated{

    [_tabar.LeftSlideVC setPanEnabled:NO];
}

//登录变化回调
-(void)StateChangedHandle{

    [ALBBService(ALBBLoginService) setSessionStateChangedHandler:^(TaeSession *session) {
        if([session isLogin]){//未登录变为已登录
            NSLog(@"[SessionStateChanged]:用户Login");
            [(TXKUserCenterViewController *)_tabar.LeftSlideVC.leftVC setupSubviewsData];
            [_tabar.LeftSlideVC setPanEnabled:YES];

        }else{//已登录变为未登录
            NSLog(@"[SessionStateChanged]:用户Logout");
            
            [_tabar.LeftSlideVC closeLeftView];
            [_tabar.LeftSlideVC setPanEnabled:NO];

        }
        [self showUserButtonOnLeft:YES withUserImageUrl:[session getUser].iconUrl];
    }];
}



//登录
-(void)didClickNavLeftButton:(UIButton *)sender{

    [self showLogin];
}
-(void)showLogin{
    id<ALBBLoginService> loginService=[[ALBBSDK sharedInstance]getService:@protocol(ALBBLoginService)];
    if(![_session isLogin]){
//        [loginService showLogin:<#(UIViewController *)#> successCallback:<#^(TaeSession *session)onSuccess#> failedCallback:<#^(NSError *error)onFailure#> notUseTaobaoAppLogin:<#(BOOL)#>]; //H5登录
        [loginService showLogin:self successCallback:^(TaeSession *session){
            NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@,登录时间:%@",[session getUser],[session getLoginTime]];
            NSLog(@"%@", tip);
        } failedCallback:^(NSError *error){
            NSLog(@"登录失败");
        }];
    }else{
        
        if (_tabar.LeftSlideVC.closed)
        {
            [_tabar.LeftSlideVC openLeftView];
        }
        
        
        NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@,登录时间:%@",[_session getUser],[_session getLoginTime]];
        NSLog(@"%@", tip);
    }
}

#pragma  mark - LeftSlideViewControllerDelegate
-(void)didLeftViewOpen{

    [UIView animateWithDuration:0.3 animations:^{
        self.tabBarController.tabBar.frame=CGRectMake(0, ScreenH, ScreenW, 49);
    }];
    

}
-(void)didLeftViewClose{
//    self.tabBarController.tabBar.hidden=NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.tabBarController.tabBar.frame=CGRectMake(0, ScreenH-49, ScreenW, 49);
    }];
}

#pragma  mark - UITableViewDatasoure
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *const resureId=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:resureId];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resureId];
    }
    
    
    return cell;
}



#pragma  mark - UITableViewDelegate



@end

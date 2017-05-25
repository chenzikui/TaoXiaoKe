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
#import "TXKADBannerView.h"
#import "TXKHomeFloorDTO.h"
#import "TXKFloorDTO.h"
#import "TXKHomeBannerFloorCell.h"
#import "TXKHomeRecommendationGoodsModel.h"
#import "TXKHomeTuijianFloorCell.h"

@interface TXKHomeViewController ()<LeftSlideViewControllerDelegate>{

    TaeSession *_session;
    HMTabBarViewController *_tabar;
}
@property(nonatomic,strong)TXKHomeFloorDTO *floors;
@property(nonatomic,strong)NSMutableArray *resureId_arr;//cell的ID
@end

@implementation TXKHomeViewController

#pragma mark - setting
-(TXKHomeFloorDTO *)floors{

    if (!_floors) {
        _floors=[[TXKHomeFloorDTO alloc]init];
    }
    return _floors;
}


-(NSMutableArray *)resureId_arr{
    
    if (!_resureId_arr) {
        _resureId_arr=[NSMutableArray arrayWithObjects:@"TXKHomeBannerFloorCell",@"TXKHomeTuijianFloorCell", nil];
    }
    return _resureId_arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    _session=[TaeSession sharedInstance];
    _tabar=(HMTabBarViewController *)self.tabBarController;
    _tabar.LeftSlideVC.delegate=self;
    
    self.tableView.frame=CGRectMake(0, 0, ScreenW, ScreenH-64-49);
    
    self.navigation_vi.title=@"主页";

    //登录变化
    [self StateChangedHandle];
    [self showUserButtonOnLeft:YES withUserImageUrl:[_session getUser].iconUrl];

    //创建主页数据
    [self.floors setupFloorDatas];
    
    [self.tableView reloadData];
    

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
    if(![_session isLogin]){
//        [loginService showLogin:<#(UIViewController *)#> successCallback:<#^(TaeSession *session)onSuccess#> failedCallback:<#^(NSError *error)onFailure#> notUseTaobaoAppLogin:<#(BOOL)#>]; //H5登录
        [ALBBService(ALBBLoginService) showLogin:self successCallback:^(TaeSession *session){
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

    return self.floors.floor_arr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    TXKFloorDTO *floor=self.floors.floor_arr[section];
    return floor.floors;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell=[self setupCustomCellWithTable:tableView withIndexPath:indexPath];
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(UITableViewCell *)setupCustomCellWithTable:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
    
    NSString *const resureId=self.resureId_arr[indexPath.section];
    TXKFloorDTO *floor=self.floors.floor_arr[indexPath.section];

    if ([floor.templateID isEqualToString:@"1"]) {
        TXKHomeBannerFloorCell *cell=[tableView dequeueReusableCellWithIdentifier:resureId];
        if (!cell) {
            cell=[[TXKHomeBannerFloorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resureId];
        }
        if (indexPath.section==0) {
            
            [cell setupCellWithDTO:floor with:indexPath];
        }
        return cell;
    }else if ([floor.templateID isEqualToString:@"4"]){
    
        TXKHomeTuijianFloorCell *cell=[tableView dequeueReusableCellWithIdentifier:resureId];
        if (!cell) {
            cell=[[TXKHomeTuijianFloorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resureId];
        }
        [cell setupCellWithArray:floor.moduleList];
        return cell;
    }

    
    
    return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    TXKFloorDTO *floor=self.floors.floor_arr[indexPath.section];
    if (floor.height==-1) {
        return [self cellHeightForIndexPath: indexPath cellContentViewWidth: [self cellContentViewWith] tableView:self.tableView];
    }
    return floor.height;
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    TXKFloorDTO *floor=self.floors.floor_arr[section];
    
    return floor.sectionHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    TXKFloorDTO *floor=self.floors.floor_arr[section];
    if ([floor.templateID isEqualToString:@"4"]) {
        UIView *bg_vi=[UIView new];
        bg_vi.backgroundColor=[UIColor groupTableViewBackgroundColor];
        
        UIImageView *section_img=[UIImageView new];
        section_img.frame=CGRectMake(10, 5, 100, 30);
        section_img.image=[UIImage imageNamed:@"home_热卖推荐"];
        [bg_vi addSubview:section_img];
        return bg_vi;
    }
    return nil;
}


#pragma  mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
}


@end

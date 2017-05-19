//
//  TXKUserCenterViewController.m
//  ALiTradeSDKDemo-iOS
//
//  Created by 陈自奎 on 17/5/18.
//  Copyright © 2017年 com.alibaba-inc.taobao. All rights reserved.
//

#import "TXKUserCenterViewController.h"
#import <ALBBSDK/ALBBWebViewService.h>
#import <ALBBLoginSDK/ALBBLoginService.h>
#import <ALBBSDK/ALBBSDK.h>


@interface TXKUserCenterViewController ()

@property(nonatomic,strong)UIImageView *user_img;
@property(nonatomic,strong)UILabel *user_id;
@property(nonatomic,strong)UILabel *user_name;
@property(nonatomic,strong)UILabel *user_loginTime;
@property(nonatomic,strong)UIButton *longinout_btn;

@end

@implementation TXKUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor redColor]];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];

    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];
    
    
    
    
    self.user_img=[[UIImageView alloc]init];
    [self.view addSubview:self.user_img];
    
    self.user_name=[self setupLabel];
    self.user_name.numberOfLines=0;
    [self.view addSubview:self.user_name];
    
    self.user_id=[self setupLabel];
    [self.view addSubview:self.user_id];
    
    self.user_loginTime=[self setupLabel];
    self.user_loginTime.numberOfLines=0;
    [self.view addSubview:self.user_loginTime];
    
    self.longinout_btn=[[UIButton alloc]init];
    [self.longinout_btn setBackgroundColor:MainColor];
    [self.longinout_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.longinout_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.longinout_btn setTitle:@"注销" forState:UIControlStateNormal];
    self.longinout_btn.layer.masksToBounds=YES;
    self.longinout_btn.layer.cornerRadius=5.0f;
    [self.longinout_btn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.longinout_btn];
    
    
    self.user_img.sd_layout.leftSpaceToView(self.view,15).topSpaceToView(self.view,100).widthIs(50).heightIs(50);
    
    self.user_name.sd_layout.leftSpaceToView(self.view,15).topSpaceToView(self.user_img,20).widthIs(200).heightIs(60);
    
//    self.user_id.sd_layout.leftEqualToView(self.user_name).topSpaceToView(self.user_name,0).widthIs(200).heightIs(40);
    
    self.user_loginTime.sd_layout.leftEqualToView(self.user_name).topSpaceToView(self.user_name,20).widthIs(200).heightIs(60);
    
    self.longinout_btn.sd_layout.leftEqualToView(self.user_name).topSpaceToView(self.user_loginTime,100).widthIs(200).heightIs(40);
    
}

-(void)setupSubviewsData{
    
    TaeSession *session=[TaeSession sharedInstance];

    NSString *img_str=VALIDATE_STRING(session.getUser.iconUrl);
    [self.user_img sd_setImageWithURL:[NSURL URLWithString:img_str] placeholderImage:nil];
    
    self.user_name.text=[NSString stringWithFormat:@"昵称: \n \n%@",session.getUser.nick];
    
    self.user_id.text=session.getUserId;
    
    self.user_loginTime.text=[NSString stringWithFormat:@"登录时间: \n \n%@",session.getLoginTime];
    
    
}

-(UILabel *)setupLabel{

    UILabel *label=[[UILabel alloc]init];
    label.textColor=[UIColor whiteColor];
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:15];
    
    return label;
}

-(void)loginOut{

    [ALBBService(ALBBLoginService) logout];
}


-(void)viewWillAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

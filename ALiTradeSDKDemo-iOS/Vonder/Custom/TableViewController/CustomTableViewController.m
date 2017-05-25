//
//  CustomTableViewController.m
//  ALiTradeSDKDemo-iOS
//
//  Created by 陈自奎 on 17/5/16.
//  Copyright © 2017年 com.alibaba-inc.taobao. All rights reserved.
//

#import "CustomTableViewController.h"


@interface CustomTableViewController ()<CustomNavHeadViewDelegate>
{
    CGFloat _oldoffset;
}


@end

@implementation CustomTableViewController

#pragma mark - setting
-(CustomTableView *)tableView{

    if (!_tableView) {
        _tableView=[[CustomTableView alloc]init];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.tableFooterView=[UIView new];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}

-(CustomNavHeadView *)navigation_vi{
    
    if (!_navigation_vi) {
        _navigation_vi=[[CustomNavHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44)];
        _navigation_vi.titleColor=[UIColor whiteColor];
        _navigation_vi.delegate=self;
    }
    return _navigation_vi;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    
    [self.navigationController.navigationBar addSubview:self.navigation_vi];
    
    
    self.tableView.frame=CGRectMake(0, 0, self.view.width, self.view.height);
    [self.view addSubview:self.tableView];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}





-(void)showbackButton{

}

-(void)showUserButtonOnLeft:(BOOL)isLeft withUserImageUrl:(NSString *)img_url{

    img_url=VALIDATE_STRING(img_url);
    
    if (isLeft) {
        
        self.navigation_vi.leftBtn.frame=CGRectMake(15, 2, 40, 40);
        [self.navigation_vi setupViewWithLayer:self.navigation_vi.leftBtn];
        [self.navigation_vi.leftBtn sd_setImageWithURL:[NSURL URLWithString:img_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"nologin_icon"]];
        [self.navigation_vi addSubview:self.navigation_vi.leftBtn];
    }else{
        self.navigation_vi.rightBtn.frame=CGRectMake(ScreenW - 55, 2, 40, 40);
        [self.navigation_vi setupViewWithLayer:self.navigation_vi.rightBtn];
        
        [self.navigation_vi.rightBtn sd_setImageWithURL:[NSURL URLWithString:img_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"nologin_icon"]];
        [self.navigation_vi addSubview:self.navigation_vi.rightBtn];
    }
}

#pragma mark - NavigationDelegate
//左按钮
-(void)NavHeadToLeft:(UIButton *)sender{
    [self didClickNavLeftButton:sender];
}

-(void)didClickNavLeftButton:(UIButton *)sender{

    if ([self.navigationController.viewControllers count]>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//右按钮回调
-(void)NavHeadToRight:(UIButton *)sender{
    NSLog(@"点击了右按钮");
    [self didClickNavRightButton:sender];
}

-(void)didClickNavRightButton:(UIButton *)sender{

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    return cell;
}






/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

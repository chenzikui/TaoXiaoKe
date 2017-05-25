//
//  HMTabBarViewController.m
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//



#import "HMTabBarViewController.h"
#import "HMNavigationController.h"
#import "HMTabBar.h"
#import "BaseSkinColor.h"
#import "TXKHomeViewController.h"
#import "TXKUserCenterViewController.h"

#define TabbarItemNums 2.0    //tabbar的数量 如果是5个设置为5.0

@interface HMTabBarViewController ()

@property (nonatomic, weak) UIViewController *lastSelectedViewContoller;

@property (nonatomic, weak) TXKHomeViewController *vc1;
//@property (nonatomic, weak) EaseUsersListViewController *resume;
//@property (nonatomic, weak) EaseConversationListViewController *message;




@end

@implementation HMTabBarViewController

-(instancetype)init{
    self=[super init];
    if (self) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // 添加所有的子控制器
    [self addAllChildVcs];
    
    // 创建自定义tabbar
    [self addCustomTabBar];
}

/**
 *  创建自定义tabbar
 */
- (void)addCustomTabBar
{
    // 创建自定义tabbar
    HMTabBar *customTabBar = [[HMTabBar alloc] init];
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];
}

/**
 *  添加所有的子控制器
 */
- (void)addAllChildVcs
{
    
//    HomeViewController *findJob = [[HomeViewController alloc] init];
//    [self addOneChlildVc:findJob title:@"主页" imageName:@"home_normal" selectedImageName:@"home_highlight"];
//    self.findJob = findJob;
//    
//
//    
//    EaseConversationListViewController *message=[[EaseConversationListViewController alloc]init];
//    [self addOneChlildVc:message title:@"消息" imageName:@"message_normal" selectedImageName:@"message_highlight"];
//    self.message = message;

    

    
    TXKHomeViewController *vc1=[[TXKHomeViewController alloc]init];
    [self addOneChlildVc:vc1 title:@"测试1" imageName:@"tabar_home" selectedImageName:@"tabar_home_select"];
    self.vc1 = vc1;
    



//    ALiDemoMainViewController *vc2=[[ALiDemoMainViewController alloc]init];
//    [self addOneChlildVc:vc2 title:@"测试2" imageName:@"home_unselected_jl" selectedImageName:@"home_selected_jl"];
//    self.personalCenter = vc2;

}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{

    
    if ([childVc isKindOfClass:[TXKHomeViewController class]]) {
        
        HMNavigationController *nav = [[HMNavigationController alloc] initWithRootViewController:childVc];
        self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:[[TXKUserCenterViewController alloc]init] andMainView:nav];

        // 设置标题
        self.LeftSlideVC.tabBarItem.title = title;
        
        // 设置图标
        self.LeftSlideVC.tabBarItem.image = [UIImage imageNamed:imageName];
        
        // 设置tabBarItem的普通文字颜色
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = TabBarButtonTitleColorNomal;
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
        [self.LeftSlideVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        
        // 设置tabBarItem的选中文字颜色
        NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
        selectedTextAttrs[NSForegroundColorAttributeName] = TabBarButtonTitleColorSelected;
        [self.LeftSlideVC.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
        
        // 设置选中的图标
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        if (iOS7) {
            // 声明这张图片用原图(别渲染)
            selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        self.LeftSlideVC.tabBarItem.selectedImage = selectedImage;
        
        // 添加为tabbar控制器的子控制器

         [self addChildViewController:self.LeftSlideVC];
    }else{
        
        // 设置标题
        childVc.tabBarItem.title = title;
        
        // 设置图标
        childVc.tabBarItem.image = [UIImage imageNamed:imageName];
        
        // 设置tabBarItem的普通文字颜色
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = TabBarButtonTitleColorNomal;
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
        [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        
        // 设置tabBarItem的选中文字颜色
        NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
        selectedTextAttrs[NSForegroundColorAttributeName] = TabBarButtonTitleColorSelected;
        [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
        
        // 设置选中的图标
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        if (iOS7) {
            // 声明这张图片用原图(别渲染)
            selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        childVc.tabBarItem.selectedImage = selectedImage;
        
        // 添加为tabbar控制器的子控制器
        HMNavigationController *nav = [[HMNavigationController alloc] initWithRootViewController:childVc];
        [self addChildViewController:nav];
    }
    
}




/***************************czk消息提示红点*******************/
//显示小红点
- (void)showBadgeOnItemIndex:(int)index{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5;//圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    CGRect tabFrame = self.tabBar.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);//圆形大小为10
    [self.tabBar addSubview:badgeView];
}

//隐藏小红点
- (void)hideBadgeOnItemIndex:(int)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

//移除小红点
- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.tabBar.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}


@end

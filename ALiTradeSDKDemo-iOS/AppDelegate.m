//
//  AppDelegate.m
//  ALiTradeSDKDemo-iOS
//
//  Created by Veight Zhou on 16/7/1.
//  Copyright © 2016年 com.alibaba-inc.taobao. All rights reserved.
//

#import "AppDelegate.h"
#import "ALiDemoMainViewController.h"
#import "HMTabBarViewController.h"
//
#import <NBSDK/ALiTradeSDK.h>

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ALiDemoMainViewController alloc] init]];
    HMTabBarViewController *tabVC=[[HMTabBarViewController alloc]init];
    self.window.rootViewController=tabVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 外部使用只能用Release环境
    [[ALiTradeSDK sharedInstance] setEnv:ALiEnvironmentRelease];
    
    // 百川平台基础SDK初始化，加载并初始化各个业务能力插件
    NSString *appKey = @"23811141";
    [[ALiTradeSDK sharedInstance] asyncInit:appKey success:^{
        
    } failure:^(NSError *error) {
        NSLog(@"Init failed: %@", error.description);
    }];
    
    // 开发阶段打开日志开关，方便排查错误信息
    [[ALiTradeSDK sharedInstance] setDebugLogOpen:YES];
    
    // 配置全局的淘客参数
    ALiTradeTaokeParams *taokeParams = [[ALiTradeTaokeParams alloc] init];
    taokeParams.pid = @"mm_123859761_0_0";
    taokeParams.unionId = nil;
    taokeParams.subPid = nil;
    [[ALiTradeSDK sharedInstance] setTaokeParams:taokeParams];
    
    // 设置全局的app标识，在电商模块里等同于isv_code
    [[ALiTradeSDK sharedInstance] setISVCode:@"your_isv_code"];
    
    // 设置全局配置，是否强制使用h5
    [[ALiTradeSDK sharedInstance] setIsForceH5:NO];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    // 如果百川处理过会返回YES
    if ([[ALiTradeSDK sharedInstance] handleOpenURL:url]) {
        // 处理其他app跳转到自己的app
        return YES;
    }
    return NO;
}


//IOS9.0 系统新的处理openURL 的API
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    //处理其他app跳转到自己的app，如果百川处理过会返回YES
    if ([[ALiTradeSDK sharedInstance] handleOpenURL:url]) {
        return YES;
    }
    
    return NO;
}

@end

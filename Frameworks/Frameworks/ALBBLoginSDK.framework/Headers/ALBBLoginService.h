//
//  ALBBLoginSDKPluginServiceProtocol.h
//  ALBBLoginSDKPluginAdapter
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 14/11/26.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TaeSession.h"

/** 回调定义 */
typedef void (^loginSuccessCallback)(TaeSession *session);
typedef void (^loginFailedCallback)(NSError *error);
typedef void (^sessionStateChangedHandler)(TaeSession *session);

@protocol ALBBLoginService
/**
 设置会话变更回调
 @param handler 会话登录状态改变时候的处理handler,可以通过TaeSession isLogin判断当前登录态
 */
- (void)setSessionStateChangedHandler:(void (^)(TaeSession *session))handler;

/**
 退出登录
 */
- (void)logout;

/**
 请求登录授权，跳转到手机淘宝登录或者本地弹出登录界面
 @param window                  当前窗口
 @param successCallback         登录授权成功的回调，返回TaeSession
 @param failedCallback          登录授权失败的回调，返回NSError
 @param notUseTaobaoAppLogin    *YES表示不要使用手机淘宝APP的登录授权，直接使用本地登录页面
 @param isBackButtonHidden      是否隐藏返回键
 */
- (void)showLoginOnRootView:(UIWindow *)window
            successCallback:(void (^)(TaeSession *session))onSuccess
             failedCallback:(void (^)(NSError *error))onFailure
       notUseTaobaoAppLogin:(BOOL)notUseTaobaoAppLogin
         isBackButtonHidden:(BOOL)isBackButtonHidden;

/**
 请求登录授权，跳转到手机淘宝登录或者本地弹出登录界面
 @param parentController        app当前的Controller
 @param successCallback         登录授权成功的回调，返回TaeSession
 @param failedCallback          登录授权失败的回调，返回NSError
 */
- (void)showLogin:(UIViewController *)parentController
  successCallback:(void (^)(TaeSession *session))onSuccess
   failedCallback:(void (^)(NSError *error))onFailure;

/**
 请求登录授权，跳转到手机淘宝登录或者本地弹出登录界面
 @param parentController        app当前的Controller
 @param successCallback         登录授权成功的回调，返回TaeSession
 @param failedCallback          登录授权失败的回调，返回NSError
 @param notUseTaobaoAppLogin    *YES表示不要使用手机淘宝APP的登录授权，直接使用本地登录页面
 */
- (void)    showLogin:(UIViewController *)parentController
      successCallback:(void (^)(TaeSession *session))onSuccess
       failedCallback:(void (^)(NSError *error))onFailure
 notUseTaobaoAppLogin:(BOOL)notUseTaobaoAppLogin;

/**
 请求登录授权，跳转到手机淘宝登录或者本地弹出登录界面
 @param parentController        app当前的Controller
 @param successCallback         登录授权成功的回调，返回TaeSession
 @param failedCallback          登录授权失败的回调，返回NSError
 @param notUseTaobaoAppLogin    *YES表示不要使用手机淘宝APP的登录授权，直接使用本地登录页面
 @param isBackButtonHidden      是否隐藏返回键
 */
- (void)    showLogin:(UIViewController *)parentController
      successCallback:(void (^)(TaeSession *session))onSuccess
       failedCallback:(void (^)(NSError *error))onFailure
 notUseTaobaoAppLogin:(BOOL)notUseTaobaoAppLogin
   isBackButtonHidden:(BOOL)isBackButtonHidden;

/**
 唤起官方扫码登录授权页面: 同步手机登陆态到其它终端
 @param parentController        app当前的Controller
 @param params                  k[shortUrl] : v[h5登录短链] 必填;
                                k[domain]   : v[业务线域标示] 有自定义样式约定时必填.
 @param successCallback         扫码登录成功的回调，返回TaeSession
 @param failedCallback          扫码登陆失败的回调，返回NSError
 */
- (void)showQRLogin:(UIViewController *)parentController
             params:(NSDictionary *)params
    successCallback:(void (^)(TaeSession *session))onSuccess
     failedCallback:(void (^)(NSError *error))onFailure;

@end

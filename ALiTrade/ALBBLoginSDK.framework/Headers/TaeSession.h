//
//  TaeSession.h
//  taesdk
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 14-8-9.
//  Copyright (c) 2014年 com.taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaeUser.h"

@interface TaeSession : NSObject

/**
 @return 返回单例
 */
+ (TaeSession *)sharedInstance;

/**
 如果未登录或者登录态已经过期,返回NO
 @return 当前会话是否登录有效
 */
- (BOOL)isLogin;

/**
 @return 返回User对象
 */
- (TaeUser *)getUser;

/**
 @return 用户id
 */
- (NSString *)getUserId;

/**
 @return 登录时间
 */
- (NSString *)getLoginTime;

/**
 top授权码
 @return return value description
 */
- (NSString *)getAuthorizationCode;

/**
 top的accessToken
 @return <#return value description#>
 */
- (NSString *)getTopAccessToken;

/**
 淘宝sessionId
 @return <#return value description#>
 */
- (NSString *)getSessionId;

@end

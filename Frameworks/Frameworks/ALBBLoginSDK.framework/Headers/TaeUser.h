//
//  TaeUser.h
//  taesdk
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 14-8-9.
//  Copyright (c) 2014年 com.taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 用户信息 */
@interface TaeUser : NSObject
/** 用户ID */
@property (nonatomic, copy) NSString *userId;
/** 昵称 */
@property (nonatomic, copy) NSString *nick;
/** 头像地址 */
@property (nonatomic, copy) NSString *iconUrl;
@end



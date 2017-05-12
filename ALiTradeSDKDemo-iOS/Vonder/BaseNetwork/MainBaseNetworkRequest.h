//
//  DHBBaseNetworkRequest.h
//  dinghuobao
//
//  Created by 阿商信息技术有限公司 on 15/9/24.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "AFNetworking.h"
#import "MainRequestAPI.h"
#import "AFHTTPSessionManager.h"

@class MainBaseNetworkRequest;

static NSString * const DHBRequestAuthorizationErrorMessage = @"DHBRequestAuthorizationErrorMessage";

typedef void (^RLBaseNetworkRequestSuccessBlock)(MainBaseNetworkRequest *DAO,id data);
typedef void (^RLBaseNetworkRequestFailedBlock)(MainBaseNetworkRequest *DAO,NSError *error);

@interface MainBaseNetworkRequest : NSObject
{
}

@property (nonatomic, assign) NSTimeInterval timeoutInterval;
@property (nonatomic, assign)BOOL hidden_effect;
@property(nonatomic,assign)BOOL isReturnDataValidate;//返回结果是否验证

- (void)getDataSuccess:(RLBaseNetworkRequestSuccessBlock)success
               failure:(RLBaseNetworkRequestFailedBlock)failure;

- (void)postDataSuccess:(RLBaseNetworkRequestSuccessBlock)success
                failure:(RLBaseNetworkRequestFailedBlock)failure;

- (void)uploadDataSuccess:(RLBaseNetworkRequestSuccessBlock)success
                  failure:(RLBaseNetworkRequestFailedBlock)failure;

- (void)AFNetworkStatus;

- (void)cancel;

- (NSString *)toJSONData:(id)theData;

#pragma mark - 由子类实现；

- (NSString *)hostName;//如主机名无变化可不用重写该方法。

- (NSString *)interfaceName;//由子类实现，指定路径。

- (id)parameters;//如无参数，子类可不用重写该方法。

- (NSData *)uploadData;//由子类重写该方法。

- (NSDictionary *)headerField; //需自定义头，子类可重写该方法。

- (NSString *)controller;//自定义控制器

- (id)value;//方法值

- (BOOL)submitValidate; //提交时的数据验证

- (BOOL)returnDataValidate:(id)returnData; //返回结果的验证

- (void)showMessage:(NSString *)str; //显示提示信息
@end

//
//  DHBBaseNetworkRequest.m
//  dinghuobao
//
//  Created by 阿商信息技术有限公司 on 15/9/24.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "MainBaseNetworkRequest.h"
#import "GiFHUD.h"

static AFHTTPSessionManager *defaultManager;
static NSTimeInterval defaultTimeoutInterval = 10;

@interface MainBaseNetworkRequest ()
{
    NSURLSessionDataTask *currenttask;
}
@end

@implementation MainBaseNetworkRequest

- (instancetype)init{
    self  = [super init];
    if (self) {
        //是否存在自定义HTTP头，如果存在则添加。
        NSDictionary *headerDic = [self headerField];
        NSURLSessionConfiguration *session = [NSURLSessionConfiguration defaultSessionConfiguration];
        if (!defaultManager) {
            if (headerDic){
                session.HTTPAdditionalHeaders=headerDic;
                defaultManager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:session];
            }else{
                defaultManager = [[AFHTTPSessionManager alloc]init];
            }
        defaultManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
            
        // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
        defaultManager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
        //defaultManager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
            
        // 超时时间
        defaultManager.requestSerializer.timeoutInterval = defaultTimeoutInterval;
            
        // 声明获取到的数据格式
        defaultManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _isReturnDataValidate = YES;//返回结果默认验证
        }

    }
    return self;
}

- (NSString *)fullURLPath
{
    //TODO:注意将此处地址集中管理。
    NSString *urlStr = MAIN_SERVICE;
    if ([self hostName])
    {
        urlStr = [self hostName];
    }
    if ([self interfaceName])
    {
        urlStr = [urlStr stringByAppendingString:[self interfaceName]];
    }
    return urlStr;
}

- (void)cancelOldOperation
{
    NSArray *tasks=defaultManager.dataTasks;
    for (NSURLSessionDataTask *task in tasks) {
        NSString *oldRequestURLStr = task.currentRequest.URL.absoluteString;
        if ([oldRequestURLStr isEqualToString:[self fullURLPath]]) {
            [task cancel];
        }
    }
}

- (void)getDataSuccess:(RLBaseNetworkRequestSuccessBlock)success failure:(RLBaseNetworkRequestFailedBlock)failure
{
    
    ////第一步: 验证提交的数据是否规范 并 验证是否能够连接到服务器(![[ParameterPublic sharedManagered] isNetWorking])
    if(![self submitValidate]){
        ///验证不通过或者无法连接到服务器，不进行数据请求
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        return;
    }
    
    //TODO:注意更新domain。
    [self cancelOldOperation];
    
//    NSLog(@"%@", NSStringFromClass([self class]));
//    NSLog_Red(@"%@",[self parameters_get]);
    //请求开始前禁用用户交互(解决网络差时，连续操作出现崩溃的问题)
    [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: NO];
    
    //get请求
    currenttask = [defaultManager GET:[self fullURLPath] parameters:[self parameters_get] progress:^(NSProgress * _Nonnull downloadProgress) {
        //获取进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        success(self, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        if (failure) {
            failure(self, error);
        }
    }];
    
}

- (void)postDataSuccess:(RLBaseNetworkRequestSuccessBlock)success failure:(RLBaseNetworkRequestFailedBlock)failure
{
    
    ////第一步: 验证提交的数据是否规范 并 验证是否能够连接到服务器(![[ParameterPublic sharedManagered] isNetWorking])
    if(![self submitValidate]){
        ///验证不通过或者无法连接到服务器，不进行数据请求
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        return;
    }
    
    ////第二步: 请求数据
    [self cancelOldOperation];

    if (!self.hidden_effect)
    {
        //显示一个新的加载动画之前，需要将之前的加载动画隐藏
        [GiFHUD dismiss];
        [GiFHUD setGifWithImageName:@"loading.gif"];
        [GiFHUD show];
        //请求开始前禁用用户交互(解决网络差时，连续操作出现崩溃的问题)
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: NO];
    }

    NSLog(@"%@",[self fullURLPath]);
    NSLog(@"%@", NSStringFromClass([self class]));
    NSLog(@"%@",[self parameters]);
    
    //post请求
    currenttask = [defaultManager POST:[self fullURLPath] parameters:[self parameters] progress:^(NSProgress * _Nonnull uploadProgress) {
        //进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        //隐藏“数据加载”视图
        if (!self.hidden_effect) [GiFHUD dismiss];
        ////第三步：返回结果的验证
        if([self returnDataValidate: responseObject]) {
            if (success) success(self, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (!self.hidden_effect) [GiFHUD dismiss];
        [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
        if (failure) {
            failure(self, error);
        }
    }];
    
}


- (void)uploadDataSuccess:(RLBaseNetworkRequestSuccessBlock)success failure:(RLBaseNetworkRequestFailedBlock)failure
{
    [self cancelOldOperation];
    

    currenttask = [defaultManager POST:[self fullURLPath] parameters:[self parameters] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:[self uploadData] name:@"file_value" fileName:[NSString stringWithFormat:@"%@.jpg",[NSDate getNowDateFormat:@"yyyyMMddHHmmssSSS"]] mimeType:@"image/jpg"];
        
        NSData *imageData =[self uploadData];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //成功
        success(self, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败
        failure(self, error);
    }];
    
}

- (void)cancel
{
    [currenttask cancel];
}

#pragma mark - 监测到网络改变

- (void)AFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
}


#pragma mark - 转JSON
- (NSString *)toJSONData:(id)theData{
    
    NSString *jsonString = @"";
    if(![NSJSONSerialization isValidJSONObject:theData])
    {
        NSLog(@"不是JSON类型数据");
        return jsonString = @"不是JSON类型数据";
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];
    if([jsonData length] > 0 && error == nil)
    {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    return jsonString = @"JSON转义失败";
}


#pragma mark - 由子类实现

- (NSString *)hostName
{
    return nil;
}

- (NSString *)interfaceName
{
    return nil;
}

#pragma mark 构造请求参数
- (id)parameters
{
    NSMutableDictionary *val = [[NSMutableDictionary alloc] initWithDictionary:[self value]];
    /*
     
     ******这里可以添加固定的一些参数
     
     */
    //test
    [val setValue:@"33861" forKey:@"showapi_appid"];
    [val setValue:@"9842e8b743e244dbbf8742a1c23fa045" forKey:@"showapi_sign"];
    
    
    return val;
}

- (id)parameters_get
{
    NSMutableDictionary *val = [[NSMutableDictionary alloc] initWithDictionary:[self value]];
    /*
     
     ******这里可以添加固定的一些参数
     
     */
    [val setValue:@"33861" forKey:@"showapi_appid"];
    [val setValue:@"9842e8b743e244dbbf8742a1c23fa045" forKey:@"showapi_sign"];
    
    return val;
}

- (NSData *)uploadData
{
    return nil;
}

- (NSDictionary *)headerField
{
    return nil;
}

- (NSString *)controller{
    return nil;
}

- (NSString *)action{
    return nil;
}

- (id)value{
    return nil;
}

#pragma mark 验证提交数据，默认有返回YES(不验证), 子类重写该方法可进行数据验证
- (BOOL)submitValidate{
    return YES;
}

#pragma mark 验证接口返回的数据，默认有返回YES(不验证), 子类重写该方法可进行数据验证
- (BOOL)returnDataValidate:(id) returnData{
    [[[UIApplication sharedApplication] keyWindow] setUserInteractionEnabled: YES];
    if (![returnData isKindOfClass:[NSDictionary class]])
    {
        [self showMessage: @"数据格式有问题"];
        return NO;
    }
    else{
        [self showMessage: @"数据获取成功"];
        [GiFHUD dismiss];
    }
    return YES;
}

#pragma mark - 显示提示信息
- (void)showMessage:(NSString *)str{
    
    NSLog(@"%@",str);
}

#pragma mark - Notification
- (void)sendAuthorizationErrorNotification
{
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"RLUserLogined"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:RLRequestAuthorizationErrorMessage object:nil];
}

//- (void)dealloc{
//    /**
//     *  当self对象销毁时，要将defaultManager(数据请求对象)清空，不然会成为野指针，引起崩溃
//     */
//    defaultManager = nil;
//}
@end

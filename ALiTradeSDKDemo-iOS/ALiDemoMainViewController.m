#import "ALiDemoMainViewController.h"

#import <NBSDK/ALiTradeSDK.h>

#import <ALBBSDK/ALBBSDK.h>
#import <ALBBLoginSDK/ALBBLoginSDK.h>


#import "AliDemoPersonalBizInfoViewController.h"
#import "ALiDemoBizViewController.h"

#import "ALiDemoWebViewController.h"

#import <ALBBLoginSDK/ALBBLoginService.h>


typedef NS_ENUM(NSInteger, kTableViewRowType) {
    // 登入测试
    kTableViewRowTypeLogin = 0,
    // 退出登入测试
    kTableViewRowTypeLogout,
    // 电商交易测试
    kTableViewRowTypeTradeBiz,
    // 个人交易信息
    kTableViewRowTypePersonalBizInfo,
    // Webview绑定
    kTableViewRowTypeWebviewBinding,
    
    kTableViewRowTypeCount,
};

@interface ALiDemoMainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ALiDemoMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"ALiTradeSDK 3.0";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Property Getters & Setters

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        Class cellClazz = [UITableViewCell class];
        [_tableView registerClass:cellClazz forCellReuseIdentifier:NSStringFromClass(cellClazz)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}


#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kTableViewRowTypeCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Class cellClazz = [UITableViewCell class];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClazz) forIndexPath:indexPath];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    kTableViewRowType row = indexPath.row;
    NSString *title = nil;
    switch (row) {
        case kTableViewRowTypeLogin: {
            title = @"登入测试";
            break;
        }
            
        case kTableViewRowTypeLogout: {
            title = @"退出登入测试";
            break;
        }
            
        case kTableViewRowTypeTradeBiz: {
            title = @"电商交易测试";
            break;
        }
            
        case kTableViewRowTypePersonalBizInfo: {
            title = @"个人交易信息";
            
            break;
        }
            
        case kTableViewRowTypeWebviewBinding: {
            title = @"Webview绑定";
            break;
        }
            
        default: {
            break;
        }
    }
    cell.textLabel.text = title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger row = indexPath.row;
    switch (row) {
        case kTableViewRowTypeLogin: {
            // 主动调用登录接口
//            [ALiService(ALBBLoginService) showLogin:[UIApplication sharedApplication].keyWindow.rootViewController
//                                    successCallback:^(TaeSession *session) {
//                 
//                                    } failedCallback:^(NSError *error) {
//                                        
//                                    } notUseTaobaoAppLogin:YES];
            [self showLogin];
            break;
        }
            // 登出 解除授权
        case kTableViewRowTypeLogout: {
            [ALiService(ALBBLoginService) logout];
            break;
        }
            
        case kTableViewRowTypeTradeBiz: {
            ALiDemoBizViewController *viewController =
            [[ALiDemoBizViewController alloc] initWithNibName:NSStringFromClass([ALiDemoBizViewController class])
                                                                    bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
            
        case kTableViewRowTypePersonalBizInfo: {
            AliDemoPersonalBizInfoViewController *viewController =
            [[AliDemoPersonalBizInfoViewController alloc] initWithNibName:NSStringFromClass([AliDemoPersonalBizInfoViewController class])
                                                                    bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
            
        
        case kTableViewRowTypeWebviewBinding: {
            id<ALiTradePage> page = [ALiTradePageFactory page:@"http://s.click.taobao.com/t?e=m%3D2%26s%3D1jBWv7M6gTUcQipKwQzePOeEDrYVVa64LKpWJ%2Bin0XJRAdhuF14FMQTfn3Ee1bdjxq3IhSJN6GTIhnv1oNPKcIu1IsQeTOU265Sw8eKESWqqgdP%2BAKekAmlX8n%2F4fqv2WdvMW3csa5338r%2Bm48V%2FzcYOae24fhW0"];
            id<ALiTradeService> service = [ALiTradeSDK sharedInstance].tradeService;
            ALiTradeShowParams *showParams = [[ALiTradeShowParams alloc] init];
            
            // 绑定WebView
        
            ALiDemoWebViewController* view = [[ALiDemoWebViewController alloc] init];
            
            // @return 0标识跳转到手淘打开了,1标识用h5打开,-1标识出错
            NSInteger res = [service
                             show:view
                             webView:view.webView
                             page:page
                             showParams:showParams
                             taoKeParams:nil
                             trackParam:nil
                             tradeProcessSuccessCallback:^(ALiTradeResult * _Nullable result) {
                
                             }
                             tradeProcessFailedCallback:^(NSError * _Nullable error) {
                
                             }];
            // @return 0标识跳转到手淘打开了,1标识用h5打开,-1标识出错
            if (res == 1) {
                [self.navigationController pushViewController:view animated:YES];
            }
            break;
        }
            
        default: {
            break;
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)showLogin{
    id<ALBBLoginService> loginService=[[ALBBSDK sharedInstance]getService:@protocol(ALBBLoginService)];
    if(![[TaeSession sharedInstance] isLogin]){
        [loginService showLogin:self successCallback:^(TaeSession *session){
            NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@,登录时间:%@",[session getUser],[session getLoginTime]];
            NSLog(@"%@", tip);
        } failedCallback:^(NSError *error){
            NSLog(@"登录失败");
        }];
    }else{
        TaeSession *session=[TaeSession sharedInstance];
        NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@,登录时间:%@",[session getUser],[session getLoginTime]];
        NSLog(@"%@", tip);
    }
}

@end

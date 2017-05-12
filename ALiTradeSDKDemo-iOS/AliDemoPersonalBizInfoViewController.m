#import "AliDemoPersonalBizInfoViewController.h"
#import <NBSDK/ALiTradeSDK.h>

@interface AliDemoPersonalBizInfoViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *openTypeSegmentedControl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *ordersTypeSegmentedControl;

- (IBAction)showMyCartAction:(id)sender;


@end

@implementation AliDemoPersonalBizInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ALiOpenType)openType {
    switch (self.openTypeSegmentedControl.selectedSegmentIndex) {
        case 0: return ALiOpenTypeAuto; break;
        case 1: return ALiOpenTypeNative; break;
        case 2: return ALiOpenTypeH5; break;
    }
    return ALiOpenTypeAuto;
}


#pragma mark - Show Pages

// 分域订单
- (IBAction)showMyOrders:(id)sender {
    // 订单状态. 0为全部订单; 1为待付款订单; 2为待发货订单; 3为待收货订单; 4为待评价订单.
    NSInteger orderType = self.ordersTypeSegmentedControl.selectedSegmentIndex;
    id<ALiTradePage> page = [ALiTradePageFactory myOrdersPage:orderType isAllOrder:NO];
    ALiTradeShowParams *showParams = [[ALiTradeShowParams alloc] init];
    showParams.openType = [self openType];
    id<ALiTradeService> service = [ALiTradeSDK sharedInstance].tradeService;
    [service
     show:showParams.isNeedPush ? self.navigationController : self
     page:page
     showParams:showParams
     taoKeParams:nil
     trackParam:nil
     tradeProcessSuccessCallback:^(ALiTradeResult * _Nullable result) {
         
     }
     tradeProcessFailedCallback:^(NSError * _Nullable error) {
         
     }];
}

// 全部订单
- (IBAction)showMyAllOrders:(id)sender {
    // 订单状态. 0为全部订单; 1为待付款订单; 2为待发货订单; 3为待收货订单; 4为待评价订单.
    NSInteger orderType = self.ordersTypeSegmentedControl.selectedSegmentIndex;
    id<ALiTradePage> page = [ALiTradePageFactory myOrdersPage:orderType isAllOrder:YES];
    ALiTradeShowParams *showParams = [[ALiTradeShowParams alloc] init];
    showParams.openType = [self openType];
    
    id<ALiTradeService> service = [ALiTradeSDK sharedInstance].tradeService;
    [service
     show:showParams.isNeedPush ? self.navigationController : self
     page:page
     showParams:showParams
     taoKeParams:nil
     trackParam:nil
     tradeProcessSuccessCallback:^(ALiTradeResult * _Nullable result) {
         
     }
     tradeProcessFailedCallback:^(NSError * _Nullable error) {
         
     }];}

// 我的购物车
- (IBAction)showMyCartAction:(id)sender {
    id<ALiTradePage> page = [ALiTradePageFactory myCartsPage];
    ALiTradeShowParams *showParams = [[ALiTradeShowParams alloc] init];
    showParams.openType = [self openType];
    id<ALiTradeService> service = [ALiTradeSDK sharedInstance].tradeService;
    [service
     show:showParams.isNeedPush ? self.navigationController : self
     page:page
     showParams:showParams
     taoKeParams:nil
     trackParam:nil
     tradeProcessSuccessCallback:^(ALiTradeResult * _Nullable result) {
        
     }
     tradeProcessFailedCallback:^(NSError * _Nullable error) {
        
    }];
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

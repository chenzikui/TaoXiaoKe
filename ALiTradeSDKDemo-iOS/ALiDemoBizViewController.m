#import "ALiDemoBizViewController.h"

#import <NBSDK/ALiTradeSDK.h>

@interface ALiDemoBizViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *itemTypeSegmentedControl; //0:普通商品 1:淘客商品
@property (weak, nonatomic) IBOutlet UISegmentedControl *openTypeSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UITextField *itemIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopIDTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *itemIDTypeSegmentedControl; //0:普通商品ID 1:混淆商品ID

@end

@implementation ALiDemoBizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

// 打开URL
- (IBAction)showURLPage:(id)sender {
    id<ALiTradePage> page = [ALiTradePageFactory page:self.urlTextField.text];
    id<ALiTradeService> service = [ALiTradeSDK sharedInstance].tradeService;
    ALiTradeShowParams *showParams = [[ALiTradeShowParams alloc] init];
    showParams.openType = [self openType];
    [service
     show:showParams.isNeedPush ? self.navigationController : self
     page:page
     showParams:showParams
     taoKeParams:nil
     trackParam:nil
     tradeProcessSuccessCallback:^(ALiTradeResult * _Nullable result) {
         
     } tradeProcessFailedCallback:^(NSError * _Nullable error) {
         
     }];
}

// 宝贝详情页面
- (IBAction)showDetailsPage:(id)sender {

    id<ALiTradePage> page = [ALiTradePageFactory itemDetailPage:self.itemIDTextField.text];
    id<ALiTradeService> service = [ALiTradeSDK sharedInstance].tradeService;
    ALiTradeShowParams *showParams = [[ALiTradeShowParams alloc] init];
    showParams.openType = [self openType];
    [service
     show:showParams.isNeedPush ? self.navigationController : self
     page:page
     showParams:showParams
     taoKeParams:nil
     trackParam:nil
     tradeProcessSuccessCallback:^(ALiTradeResult * _Nullable result) {
         
     } tradeProcessFailedCallback:^(NSError * _Nullable error) {
         
     }];
}

// 加入购物车
- (IBAction)showAddToCartPage:(id)sender {
    id<ALiTradePage> page = [ALiTradePageFactory addCartPage:self.itemIDTextField.text];
    id<ALiTradeService> service = [ALiTradeSDK sharedInstance].tradeService;
    ALiTradeShowParams *showParams = [[ALiTradeShowParams alloc] init];
    
    // 如果是淘客商品， 可以自己配置淘客参数
    ALiTradeTaokeParams *taokeParams = [[ALiTradeTaokeParams alloc] init];
    if (self.itemTypeSegmentedControl.selectedSegmentIndex == 1) {
//        taokeParams.subPid = @"xxxx";
    }
    showParams.openType = [self openType];
    [service
     show:showParams.isNeedPush ? self.navigationController : self
     page:page
     showParams:showParams
     taoKeParams:taokeParams
     trackParam:nil
     tradeProcessSuccessCallback:^(ALiTradeResult * _Nullable result) {
        
     } tradeProcessFailedCallback:^(NSError * _Nullable error) {
        
    }];
}

// 店铺页面
- (IBAction)showShopPage:(id)sender {
    id<ALiTradePage> page = [ALiTradePageFactory shopPage:self.shopIDTextField.text];
    id<ALiTradeService> service = [ALiTradeSDK sharedInstance].tradeService;
    ALiTradeShowParams *showParams = [[ALiTradeShowParams alloc] init];
    showParams.openType = [self openType];
    [service
     show:showParams.isNeedPush ? self.navigationController : self
     page:page
     showParams:showParams
     taoKeParams:nil
     trackParam:nil
     tradeProcessSuccessCallback:^(ALiTradeResult * _Nullable result) {
         
     } tradeProcessFailedCallback:^(NSError * _Nullable error) {
     }];
}


#pragma mark - Actions

- (IBAction)itemIDTypeChangedAction:(id)sender {
    self.itemIDTextField.text = self.itemIDTypeSegmentedControl.selectedSegmentIndex ?  @"AAHPt-dcABxGVVui-VRMv5Gm" : @"41576306115";
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

//
//  WLWebController.m
//  WangliBank
//
//  Created by 王启镰 on 16/6/21.
//  Copyright © 2016年 iSoftstone infomation Technology (Group) Co.,Ltd. All rights reserved.
//

#import "CustomWebController.h"


@interface CustomWebController ()

@property(nonatomic,strong)UILabel *title_lb;

@end

@implementation CustomWebController
{
    

}

-(void)setTitle:(NSString *)title{
    
    self.title_lb.text=title;
    
}

-(UILabel *)title_lb{

    if (!_title_lb) {
        _title_lb=[UILabel new];
        _title_lb.backgroundColor=[UIColor clearColor];
        _title_lb.textColor=[UIColor whiteColor];
        _title_lb.font=[UIFont systemFontOfSize:17];
        _title_lb.textAlignment=NSTextAlignmentCenter;
    }
    return _title_lb;
}

-(UIWebView *)webView{

    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}

-(UIView *)customNavigationView{

    if (!_customNavigationView) {
        _customNavigationView=[[UIView alloc]init];
        _customNavigationView.backgroundColor=MainColor;
        
        UIButton *leftButton = [[UIButton alloc]init];
        leftButton.frame = CGRectMake(10, 32, 20, 20);
        [leftButton setBackgroundImage:[UIImage imageNamed:@"nav_back_button"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [_customNavigationView addSubview:leftButton];
        
        [_customNavigationView addSubview:self.title_lb];
        self.title_lb.sd_layout.leftSpaceToView(_customNavigationView,40).rightSpaceToView(_customNavigationView,40).bottomSpaceToView(_customNavigationView,0).heightIs(44);
    }
    return _customNavigationView;
}

-(CustomWebProgressLayer *)progressLayer{

    if (!_progressLayer) {
        _progressLayer = [CustomWebProgressLayer new];
        _progressLayer.frame = CGRectMake(0, 60, SCREEN_WIDTH, 2);
    }
    return _progressLayer;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}
-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated{

    self.navigationController.navigationBarHidden=NO;

}

- (void)setupUI {
    
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    [self.view addSubview:self.customNavigationView];
//    self.customNavigationView.sd_layout.topEqualToView(self.view).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(64);
    self.customNavigationView.frame=CGRectMake(0, 0, ScreenW, 64);

    
    [self.view addSubview:self.webView];
//    self.webView.sd_layout.topSpaceToView(self.view,64).leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
    self.webView.frame=CGRectMake(0, 64, ScreenW, ScreenH-64);
    
    [self.navigationController.navigationBar.layer addSublayer:self.progressLayer];
    [self.customNavigationView.layer addSublayer:self.progressLayer];
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.progressLayer startLoad];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.progressLayer finishedLoad];
//    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.webView stringByEvaluatingJavaScriptFromString:
     @"[].forEach.call(document.querySelectorAll('img'), function(item) {item.style.width='100%';item.style.height='auto';});"];
//     [webView stringByEvaluatingJavaScriptFromString:@"javascript:document.getElementById('_csGDTContainer').style.display='none';"];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.progressLayer finishedLoad];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"%@",request.URL.absoluteString);
    
    return YES;
}

- (void)dealloc {
    
    [self.progressLayer closeTimer];
    [self.progressLayer removeFromSuperlayer];
    self.progressLayer = nil;
    NSLog(@"i am dealloc");
}





@end

//
//  SJWebViewController.m
//  Yunpan
//
//  Created by 陈少杰 on 15/8/3.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJWebViewController.h"
#import "SJWebView.h"
#import "SJButtonActionSheet.h"
#import "SJShareCenter.h"
#import "SJAdsController.h"
#import <SVProgressHUD.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApi.h>
#import <SJSettingRecode.h>
#import "SJIKnowTipView.h"
#import "config.h"

@interface SJWebViewController ()<UIWebViewDelegate,WKNavigationDelegate>
@property(nonatomic)SJWebView *mainView;
@end

@implementation SJWebViewController
-(void)loadUI{
    self.mainView.webView.delegate=self;
    self.mainView.webView.scalesPageToFit=NO;//!self.isLocationFile;

    if (!self.isLocationFile) {
        [self quicklyCreateRightItemWithTitle:@"分享资源" titleColorHex:@"313746" titleHighlightedColorHex:nil selector:@selector(more)];
    }
}

-(void)more{
   SJButtonActionSheet *actionSheet=[[SJButtonActionSheet alloc]initWithTitle:@"分享结果到"];
    
    [actionSheet addButtonWithTitle:@"Safari打开" image:[UIImage imageNamed:@"更多_icon_safari"] block:^{
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.webURL]];
    }];
    
    [actionSheet addButtonWithTitle:@"复制链接" image:[UIImage imageNamed:@"更多_复制链接"] block:^{
        [MobClick event:@"02-03"];
        UIPasteboard *pb=[UIPasteboard generalPasteboard];
        [pb setString:self.webURL];
    }];
    
    if ([WXApi isWXAppInstalled]) {
        [actionSheet addButtonWithTitle:@"微信好友" image:[UIImage imageNamed:@"更多_icon_微信"] block:^{
            [SJShareCenter shareTo:ShareTypeWeixiSession url:self.webURL content:self.contentString];
        }];
        
        [actionSheet addButtonWithTitle:@"朋友圈" image:[UIImage imageNamed:@"更多_icon_朋友圈"] block:^{
            [SJShareCenter shareTo:ShareTypeWeixiTimeline url:self.webURL content:self.contentString];
        }];
    }
    
    if ([QQApi isQQInstalled]) {
        [actionSheet addButtonWithTitle:@"QQ/Qzone" image:[UIImage imageNamed:@"更多_icon_QQ空间"] block:^{
            [SJShareCenter shareTo:ShareTypeQQ url:self.webURL content:self.contentString];
        }];
    }
    
    [actionSheet showInView:nil];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    if(error){
//        [SVProgressHUD showErrorWithStatus:@"网络异常" maskType:SVProgressHUDMaskTypeBlack];
//    }
    if([[webView.request.URL absoluteString]isEqualToString:self.webURL]){
         [SVProgressHUD showErrorWithStatus:@"网络异常" maskType:SVProgressHUDMaskTypeBlack];
    }
}



-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"UserAgent = %@", [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]);
    [SVProgressHUD dismiss];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
//
    if([[webView.request.URL absoluteString]isEqualToString:self.webURL]){
//        alert(@"正在加载");
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=self.contentString;
    
    NSMutableURLRequest *requset=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:self.webURL]];
    [requset setValue:@"Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5" forHTTPHeaderField:@"User-Agent"];
    
    [SVProgressHUD showWithStatus:@"正在加载" maskType:SVProgressHUDMaskTypeBlack];
    if([self.webURL rangeOfString:@"pan.baidu.com"].length>0){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError *error;
            NSString *html=[[NSString alloc]initWithData:[NSURLConnection sendSynchronousRequest:requset returningResponse:nil error:&error] encoding:NSUTF8StringEncoding];
            dispatch_async(dispatch_get_main_queue(),^{
                if (error) {
                    [SVProgressHUD showErrorWithStatus:@"网络异常"];
                }else{
                    [self.mainView.webView loadHTMLString:html baseURL:[NSURL URLWithString:self.webURL]];
                }
                
            });
        });
    
    }else{
        [self.mainView.webView loadRequest:requset];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    if (!IS_IPHONE4()) {
        [SJAdsController removeAdsBanner];
    }
    [MobClick beginLogPageView:@"资源页"];
}

-(void)viewDidAppear:(BOOL)animated{
//    BOOL hideTip=[[SJSettingRecode getSet:@"hideTip"]boolValue];
//    if (!hideTip) {
//       [SJIKnowTipView showInViewWithTitle:@"tip:右上角更多按钮可获取链接或分享" iKnowDesc:nil successBlock:^(UIView *thisView) {
//           SJIKnowTipView *t=(SJIKnowTipView *)thisView;
//           if (t.iKnowBtn.selected) {
//               [SJSettingRecode set:@"hideTip" value:@"1"];
//           }
//        }];
//    }
}

-(void)viewWillDisappear:(BOOL)animated{
    if (!IS_IPHONE4()) {
        [SJAdsController showAdsBanner];
    }
    [SVProgressHUD dismiss];
    [MobClick endLogPageView:@"资源页"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

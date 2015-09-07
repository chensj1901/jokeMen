//
//  SJAdsController.m
//  bounceBall
//
//  Created by 陈少杰 on 15/6/29.
//
//

#import "SJAdsController.h"
#import "config.h"
#import <AdMoGoView.h>
#import <MobClick.h>
#import <SJSettingRecode.h>
#import "SJRecommendApp.h"

static SJAdsController *_adsController;

@interface SJAdsController ()<AdMoGoDelegate>
@property(nonatomic)SJRecommendApp *recommendApp;
@end

@implementation SJAdsController
@synthesize adMoGoView=_adMoGoView;

+(SJAdsController *)shareController{
    if(!_adsController){
        _adsController=[[SJAdsController alloc]init];
    }
    return _adsController;
}

+(void)showAdsBanner{
    SJAdsController *ads=[self shareController];
    [ads showAdsBanner];
}

+(void)removeAdsBanner{
    [[self shareController]removeAdsBanner];
}

+(void)showPushAds{
    SJAdsController *ads=[self shareController];
    [ads showPushAds];
}
-(void)showPushAds{
    [SJSettingRecode initDB];
    if ([[SJSettingRecode getSet:@"notFirst"]boolValue]) {
        [self getAppRecommendWithSuccess:^{
            SJRecommendApp *app=self.recommendApp;
            NSString *tag=[NSString stringWithFormat:@"ads_count_%ld",(long)self.recommendApp._id];
            NSDateFormatter *format=[[NSDateFormatter alloc]init];
            [format setDateFormat:@"Y-M-d"];
            
            NSString *dateTag=[NSString stringWithFormat:@"ads_showAt_%@",[format stringFromDate:[NSDate date]]];
            if (![[SJSettingRecode getSet:[NSString stringWithFormat:@"ads_%ld",(long)self.recommendApp._id]]boolValue]&&[[SJSettingRecode getSet:tag]integerValue]<2&&[app.url hasPrefix:@"http"]&&[[SJSettingRecode getSet:dateTag]boolValue]==0) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MobClick event:@"03_01"];
                    
                    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:app.appName message:app.appDesc delegate:self cancelButtonTitle:nil otherButtonTitles:@"不了",@"去看看🍀", nil];
                    [alertView show];
                    if (arc4random()%3==1) {
                        [SJSettingRecode set:dateTag value:@"1"];
                    }
                });
            }
        } fail:^(NSError *error) {
            
        }];
    }else{
        [SJSettingRecode set:@"notFirst" value:@"1"];
    }
}

-(void)getAppRecommendWithSuccess:(void(^)(void))success fail:(void(^)(NSError* error))fail{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *url=[NSString stringWithFormat:@"%@/op.php?op=getRecommendApp&bid=%@",@"http://1.jhwg.sinaapp.com/gaoxiao",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
        NSError *err1;
        NSData *data=[NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] returningResponse:nil error:&err1];
        NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSError *err2;
        id dic=[NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&err2];
        dispatch_async(dispatch_get_main_queue(),^{
            if (err1||err2) {
                NSError *error=err1?err1:err2;
                if (fail) {
                    fail(error);
                }
            }else{
                @try {
                    if ([dic isKindOfClass:[NSDictionary class]]&&[dic[@"app"]isKindOfClass:[NSDictionary class]]) {
                        SJRecommendApp *app=[[SJRecommendApp alloc]initWithDictionary:dic[@"app"]];
                        self.recommendApp=app;
                        
                        if (success) {
                            success();
                        }
                    }else{
                        NSError *error=[NSError errorWithDomain:@"404" code:404 userInfo:nil];
                        if (fail) {
                            fail(error);
                        }
                    }
                }
                @catch (NSException *exception) {
                    NSError *error=[NSError errorWithDomain:@"404" code:404 userInfo:nil];
                    if (fail) {
                        fail(error);
                    }
                    
                }
                @finally {
                    
                }
            }
        });
    });
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [MobClick event:@"03_03"];
        NSString *tag=[NSString stringWithFormat:@"ads_count_%ld",(long)self.recommendApp._id];
        [SJSettingRecode set:tag value:[NSString stringWithFormat:@"%ld",([[SJSettingRecode getSet:tag]integerValue]+1)]];
    }
    if (buttonIndex==1) {
        [MobClick event:@"03_02"];
        
        [SJSettingRecode set:[NSString stringWithFormat:@"ads_%ld",(long)self.recommendApp._id] value:@"1"];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.recommendApp.url]];
    }
}

-(AdMoGoView *)adMoGoView{
    if (!_adMoGoView) {
        _adMoGoView=[[AdMoGoView alloc]initWithAppKey:ADS_MOGO_APPKEY adType:AdViewTypeNormalBanner adMoGoViewDelegate:self adViewPointType:AdMoGoViewPointTypeDown_middle];
    }
    return _adMoGoView;
}


-(void)showAdsBanner{
    UIWindow *mainWindow=[[[UIApplication sharedApplication]windows]objectAtIndex:0];
    [mainWindow addSubview:self.adMoGoView];
}

-(void)removeAdsBanner{
    [self.adMoGoView removeFromSuperview];
    self.adMoGoView=nil;
}


#pragma mark -
#pragma mark AdMoGoDelegate delegate

- (UIViewController *)viewControllerForPresentingModalView{
    UIWindow *mainWindow=[[[UIApplication sharedApplication]windows]objectAtIndex:0];
    return mainWindow.rootViewController;
}


- (void)adMoGoDidStartAd:(AdMoGoView *)adMoGoView{
    NSLog(@"广告开始请求回调");}


- (void)adMoGoDidReceiveAd:(AdMoGoView *)adMoGoView{
    [MobClick event:@"01-01"];

    NSLog(@"%@",NSStringFromCGRect(adMoGoView.frame));
    CGRect frame=adMoGoView.frame;
    frame.origin.y=[UIScreen mainScreen].bounds.size.height-50;
    frame.origin.x=([UIScreen mainScreen].bounds.size.width-frame.size.width)/2;
    adMoGoView.frame=frame;
    NSLog(@"广告接收成功回调");
}


- (void)adMoGoDidFailToReceiveAd:(AdMoGoView *)adMoGoView didFailWithError:(NSError *)error{
    NSLog(@"广告接收失败回调");
    
}
 
- (void)adMoGoClickAd:(AdMoGoView *)adMoGoView{
    [MobClick event:@"01-02"];
    NSLog(@"点击广告回调");
}

- (void)adMoGoDeleteAd:(AdMoGoView *)adMoGoView{
    NSLog(@"广告关闭回调");
}

-(void)adMoGoWillPresentFullScreenModal{
    [SJAdsController shareController].adMoGoView.hidden=YES;
}

-(void)adMoGoDidDismissFullScreenModal{
    [SJAdsController shareController].adMoGoView.hidden=NO;
}
#pragma mark -
#pragma mark AdMoGoWebBrowserControllerUserDelegate delegate


- (void)webBrowserWillAppear{
    NSLog(@"浏览器将要展示");
}

- (void)webBrowserDidAppear{
    NSLog(@"浏览器已经展示");
}

- (void)webBrowserWillClosed{
    NSLog(@"浏览器将要关闭");
}

- (void)webBrowserDidClosed{
    NSLog(@"浏览器已经关闭");
}

-(BOOL)shouldAlertQAView:(UIAlertView *)alertView{
    return NO;
}

- (void)webBrowserShare:(NSString *)url{
    
}

@end

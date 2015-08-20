//
//  AppDelegate.m
//  Yunpan
//
//  Created by 陈少杰 on 15/8/3.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "AppDelegate.h"
#import "SJIndexSwitchViewController.h"
#import <MobClick.h>
#import "config.h"
#import "SJAdsController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "SJNavigationController.h"
#import <iRate.h>
#import <SJSettingRecode.h>
#import "SJJokeURLRequest.h"
#import "SJJoke.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)updateUA{
    @autoreleasepool {
        NSString *ua=@"Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5";
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":ua}];
    }
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
    [self updateUA];
    [SJSettingRecode initDB];
    // Override point for customization after application launch.
    [MobClick startWithAppkey:UMENG_APPKEY];
    SJIndexSwitchViewController *indexVC=[[SJIndexSwitchViewController alloc]init];
    SJNavigationController *nav=[[SJNavigationController alloc]initWithRootViewController:indexVC];
    nav.navigationBar.tintColor=[UIColor colorWithHex:@"888888"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.rootViewController=nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self initPlatform];
    [SJAdsController showAdsBanner];
    
    [iRate sharedInstance].applicationBundleID=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    [iRate sharedInstance].usesUntilPrompt=5;
    [iRate sharedInstance].daysUntilPrompt=3;
    
    if (IS_IOS7()) {
        [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:60*60*4];
    }
    return YES;
}

-(void)initPlatform{
    [ShareSDK registerApp:@"api20"];//字符串api20为您的ShareSDK的AppKey
    
    [ShareSDK connectWeChatWithAppId:@"wx2fc4506ed5e18353"   //微信APPID
                           appSecret:@"d350493219e33b23833327e86d856a74"  //微信APPSecret
                           wechatCls:[WXApi class]];
    
    
    //添加QQ应用  注册网址   http://mobile.qq.com/api/
    [ShareSDK connectQQWithQZoneAppKey:@"1104724651"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSTimeInterval time=[[SJSettingRecode getSet:@"pushTime"]doubleValue];
    NSTimeInterval now=[[NSDate date]timeIntervalSince1970];
    if (now-time>60*60*2) {
        [SJJokeURLRequest apiLoadOneJokeWithSuccess:^(AFHTTPRequestOperation *op, id dictionary) {
            SJJoke *joke=[[SJJoke alloc]initWithRemoteDictionary:[dictionary safeObjectForKey:@"joke"]];
            if (joke._id!=[[SJSettingRecode getSet:@"jokeId"]integerValue]) {
                [SJSettingRecode set:@"jokeId" value:[NSString stringWithFormat:@"%ld",(long)joke._id]];
                [SJSettingRecode set:@"pushTime" value:[NSString stringWithFormat:@"%f",now]];
                [self sendLocationPush:joke.content];
            }
        } failure:^(AFHTTPRequestOperation *o, NSError *e) {
            
        }];
    }else{
//        [self sendLocationPush:@"HELLO"];
    
    }
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:60*60*4];
    completionHandler(UIBackgroundFetchResultNewData);
}
-(void)sendLocationPush:(NSString *)string{
    UILocalNotification *notification=[[UILocalNotification alloc]init];
    NSDate *pushDate = [NSDate dateWithTimeIntervalSinceNow:2];
    if (notification != nil) {
        notification.fireDate = pushDate;
        // 设置时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 设置重复间隔
        notification.repeatInterval = kCFCalendarUnitDay;
        // 推送声音
        notification.soundName = UILocalNotificationDefaultSoundName;
        
        static NSString* const KDateFormat=@"yyyy-MM-dd HH:mm";
        NSDateFormatter* dateFormat=[[NSDateFormatter alloc] init];
        dateFormat.dateFormat=KDateFormat;
        
        // 推送内容
        notification.alertBody = [NSString stringWithFormat:@"%@",string];
        //显示在icon上的红色圈中的数子
        //        notification.applicationIconBadgeNumber = 1;
        //设置userinfo 方便在之后需要撤销的时候使用
        
        NSDictionary *info = [NSDictionary dictionaryWithObject:@"startEdit"forKey:@"startEdit"];
        notification.userInfo = info;
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notification];
        
    }
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

@end

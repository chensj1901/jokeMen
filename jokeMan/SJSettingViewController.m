//
//  SJSettingViewController.m
//  Yunpan
//
//  Created by 陈少杰 on 15/8/4.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJSettingViewController.h"
#import "SJSettingView.h"
#import "SJSettingCell.h"
#import "SJShareCenter.h"
#import "SJButtonActionSheet.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApi.h>
#import "SJWebViewController.h"
#import "SJRecommendAppViewController.h"
#import "config.h"

@interface SJSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic)SJSettingView *mainView;
@property(nonatomic)NSArray *titles;
@end

@implementation SJSettingViewController
-(void)loadSetting{
    self.titles=@[@[@"精选推荐"],@[@"免责声明",@"给我们打个分",@"把我们分享给好友"]];
}

-(void)loadUI{
    self.mainView.detailTableView.delegate=self;
    self.mainView.detailTableView.dataSource=self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId=@"SJSettingCell";
    SJSettingCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[SJSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.titleLabel.text=[[self.titles safeObjectAtIndex:indexPath.section]safeObjectAtIndex:indexPath.row];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.titles count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.titles safeObjectAtIndex:section]count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SJSettingCell cellHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *appIndexURL;
    

    
    
    NSString *title=[[self.titles safeObjectAtIndex:indexPath.section]safeObjectAtIndex:indexPath.row];
    if ([title isEqualToString:@"精选推荐"]) {
        SJRecommendAppViewController *appVC=[[SJRecommendAppViewController alloc]init];
        [self.navigationController pushViewController:appVC animated:YES];
    }else if ([title isEqualToString:@"免责声明"]){
        NSString *aboutStr=[[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"about" ofType:@"html"]]absoluteString];
        SJWebViewController *webVC=[[SJWebViewController alloc]init];
        webVC.isLocationFile=YES;
        webVC.webURL=aboutStr;
        [self.navigationController pushViewController:webVC animated:YES];
    }else if ([title isEqualToString:@"给我们打个分"]){
        if (([[[UIDevice currentDevice]systemVersion]doubleValue])>=7.0) {
            appIndexURL=[NSString stringWithFormat: @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8", APPLE_ID];
        }else{
            appIndexURL = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", APPLE_ID];
        }

        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:appIndexURL]];
    }else if ([title isEqualToString:@"把我们分享给好友"]){
        if (([[[UIDevice currentDevice]systemVersion]doubleValue])>=7.0) {
            appIndexURL = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",APPLE_ID];
        } else {
            appIndexURL = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", APPLE_ID];
        }
        
        SJButtonActionSheet *actionSheet=[[SJButtonActionSheet alloc]initWithTitle:@""];
        
        [actionSheet addButtonWithTitle:@"复制链接" image:[UIImage imageNamed:@"更多_复制链接"] block:^{
            [MobClick event:@"02-03"];
            UIPasteboard *pb=[UIPasteboard generalPasteboard];
            [pb setString:appIndexURL];
        }];
        
        if ([WXApi isWXAppInstalled]) {
        [actionSheet addButtonWithTitle:@"微信好友" image:[UIImage imageNamed:@"更多_icon_微信"] block:^{
            [SJShareCenter shareTo:ShareTypeWeixiSession url:appIndexURL content:@"这个真心不能错过，笑死俺了！"];
        }];
        
        [actionSheet addButtonWithTitle:@"朋友圈" image:[UIImage imageNamed:@"更多_icon_朋友圈"] block:^{
            [SJShareCenter shareTo:ShareTypeWeixiTimeline url:appIndexURL content:@"这个真心不能错过，笑死俺了！"];
        }];
        }
        
        if ([QQApi isQQInstalled]) {
        [actionSheet addButtonWithTitle:@"QQ" image:[UIImage imageNamed:@"更多_icon_QQ"] block:^{
            [SJShareCenter shareTo:ShareTypeQQ url:appIndexURL content:@"这个真心不能错过，笑死俺了！"];
        }];
        }
        
        [actionSheet showInView:nil];
        
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [MobClick beginLogPageView:@"设置页"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [MobClick endLogPageView:@"设置页"];
}
@end

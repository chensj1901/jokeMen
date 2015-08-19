//
//  SJIndexSwitchViewController.m
//  Yunpan
//
//  Created by 陈少杰 on 15/8/4.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJIndexSwitchViewController.h"
#import "SJIndexViewController.h"
#import "SJSettingViewController.h"
#import "SJTabSwitchView.h"
#import "SJAdsController.h"

@interface SJIndexSwitchViewController ()
@property(nonatomic)SJTabSwitchView *tabSwitchView;
@property(nonatomic)SJIndexViewController *indexVC;
@property(nonatomic)SJSettingViewController *settingVC;
@end

@implementation SJIndexSwitchViewController

-(SJTabSwitchView *)tabSwitchView{
    if (!_tabSwitchView) {
        CGFloat ios7Offset=IS_IOS7()?0:44;
        _tabSwitchView=[[SJTabSwitchView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-50-ios7Offset, WIDTH, 44)];
    }
    return _tabSwitchView;
}



-(void)loadTarget{
    self.tabSwitchView.indexBtn.selected=YES;
    
    [self.tabSwitchView.indexBtn addTarget:self action:@selector(selectIndexVC) forControlEvents:UIControlEventTouchUpInside];
    [self.tabSwitchView.settingBtn addTarget:self action:@selector(selectSettingVC) forControlEvents:UIControlEventTouchUpInside];
}

-(void)selectIndexVC{
    [self setShowingIndex:0 animate:YES];
    
}

-(void)selectSettingVC{
    [self setShowingIndex:1 animate:YES];
}

-(CGRect)rectOfView{
    return CGRectMake(0, 0, WIDTH, HEIGHT);
}

-(NSInteger)numberOfSwitchViewController{
    return 2;
}

-(UIViewController *)switchViewControllerDidGetViewControllerAtIndex:(NSUInteger)index{
    UIViewController *vc=nil;
    switch (index) {
        case 0:
            vc=self.indexVC;
            break;
        case 1:
            vc=self.settingVC;
            break;
        default:
            break;
    }
    return vc;
}

-(void)switchViewControllerDidStopAtIndex:(NSInteger)index{
    
    self.tabSwitchView.indexBtn.selected=index==0;
    self.tabSwitchView.settingBtn.selected=index==1;
}

-(SJIndexViewController *)indexVC{
    if (!_indexVC) {
        _indexVC=[[SJIndexViewController alloc]init];
    }
    return _indexVC;
}

-(SJSettingViewController *)settingVC{
    if (!_settingVC) {
        _settingVC=[[SJSettingViewController alloc]init];
    }
    return _settingVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView=self.tabSwitchView;
    [self loadTarget];
}

-(void)viewDidAppear:(BOOL)animated{
    [self switchViewControllerDidStopAtIndex:self.showingIndex];
}

-(void)viewWillDisappear:(BOOL)animated{
    if(IS_IPHONE4()){
        [SJAdsController removeAdsBanner];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    if(IS_IPHONE4()){
        [SJAdsController showAdsBanner];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self loadTarget];
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

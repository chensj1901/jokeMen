//
//  SJRecommendAppViewController.m
//  zhitu
//
//  Created by 陈少杰 on 13-11-29.
//  Copyright (c) 2013年 聆创科技有限公司. All rights reserved.
//

#import "SJRecommendAppViewController.h"
#import "SJRecommendAppView.h"
#import "SJRecommendAppCell.h"
#import "SJRecommendApp.h"
#import "SJRecommendAppService.h"
#import <SVProgressHUD.h>

@interface SJRecommendAppViewController ()<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>
{
    SJRecommendAppView *_mainView;
    NSUInteger _maxId;
}
@property(nonatomic)SJRecommendAppService *appService;
@end

@implementation SJRecommendAppViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self loadSetting];
    }
    return self;
}

-(SJRecommendAppService *)appService{
    if (!_appService) {
        _appService=[[SJRecommendAppService alloc]init];
    }
    return _appService;
}


-(void)loadAppList{
    [self.appService loadAppListWithSuccess:^{
        [_mainView.appsTableView reloadData];
    } fail:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常" maskType:SVProgressHUDMaskTypeBlack];
    }];
}

-(void)loadSetting{
    IOS7_LAYOUT();
    self.hidesBottomBarWhenPushed=YES;
}

-(void)loadUI{
    _mainView=[[SJRecommendAppView alloc]initWithFrame:MAINVIEW_HEIGHT_HASNAVBAR_NOTABBAR_RECT];
    _mainView.appsTableView.delegate=self;
    _mainView.appsTableView.dataSource=self;
    _mainView.appsTableView.pullDelegate=self;
    self.navigationItem.title=@"精选推荐";
    [self.view addSubview:_mainView];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str=@"cellId";
    SJRecommendApp *app=[self.appService.apps objectAtIndex:indexPath.row];
    SJRecommendAppCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[SJRecommendAppCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        [[cell downloadButton]addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
    }
    [cell setAppDesc:app.appDesc];
    [cell setAppName:app.appName];
    [cell setAppIconURL:app.appIcon];
    return cell;
}

-(void)download:(UIButton*)button{
  [MobClick event:@"01-03"];
  NSIndexPath*indexPath=[_mainView.appsTableView indexPathForCellElement:button];
    SJRecommendApp *app=[self.appService.apps objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:app.url]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.appService.apps count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"应用推荐页"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [MobClick endLogPageView:@"应用推荐页"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadUI];
    [self loadAppList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

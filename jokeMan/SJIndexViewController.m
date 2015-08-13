//
//  SJIndexViewController.m
//  Yunpan
//
//  Created by 陈少杰 on 15/8/3.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJIndexViewController.h"
#import "SJIndexView.h"

@interface SJIndexViewController ()<UITextFieldDelegate>
@property(nonatomic)SJIndexView *mainView;
@end

@implementation SJIndexViewController

-(void)loadUI{
    self.navigationItem.title=@"云盘搜索";

}

-(void)loadTarget{
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [MobClick beginLogPageView:@"主页"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [MobClick endLogPageView:@"主页"];
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

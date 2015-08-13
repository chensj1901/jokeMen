//
//  SJIndexViewController.m
//  Yunpan
//
//  Created by 陈少杰 on 15/8/3.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJIndexViewController.h"
#import "SJIndexView.h"
#import "SJJokeService.h"
#import "SJJokeCell.h"

@interface SJIndexViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)SJIndexView *mainView;
@property(nonatomic)SJJokeService *jokeService;
@end

@implementation SJIndexViewController
-(SJJokeService *)jokeService{
    if (!_jokeService) {
        _jokeService=[[SJJokeService alloc]init];
    }
    return _jokeService;
}

-(void)loadUI{
    self.navigationItem.title=@"云盘搜索";
    
    self.mainView.detailTableView.delegate=self;
    self.mainView.detailTableView.dataSource=self;

}

-(void)loadTarget{
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.jokeService.jokes count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"<##>";
    SJJokeCell *cell=[self.mainView.detailTableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[SJJokeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    SJJoke *joke=[self.jokeService.jokes safeObjectAtIndex:indexPath.row];
    [cell loadJoke:joke];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SJJoke *joke=[self.jokeService.jokes safeObjectAtIndex:indexPath.row];
    return [SJJokeCell cellHeightWithJoke:joke];
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

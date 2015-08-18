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
#import "SJShareCenter.h"
#import "SJButtonActionSheet.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApi.h>

@interface SJIndexViewController ()<UITableViewDelegate,UITableViewDataSource,PullTableViewDelegate>
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
    self.navigationItem.title=@"";
    
    self.mainView.detailTableView.delegate=self;
    self.mainView.detailTableView.dataSource=self;
    self.mainView.detailTableView.pullDelegate=self;

}

-(void)loadTarget{
    
    
}

-(void)loadFirstJokeWithCache:(SJCacheMethod)cacheMethod{
[self.jokeService loadFirstJokeWithcacheMethod:cacheMethod success:^{
    if (cacheMethod!=SJCacheMethodOnlyCache&&self.mainView.detailTableView.pullTableIsRefreshing) {
        self.mainView.detailTableView.pullTableIsRefreshing=NO;
    }
    [self.mainView.detailTableView reloadData];
} fail:^(NSError *error) {
    
}];
}

-(void)loadMoreJoke{
    [self.jokeService loadMoreJokeWithSuccess:^{
        if (self.mainView.detailTableView.pullTableIsLoadingMore) {
            self.mainView.detailTableView.pullTableIsLoadingMore=NO;
        }
        [self.mainView.detailTableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}

-(void)like:(UIButton *)btn{
    NSIndexPath *indexPath=[self.mainView.detailTableView indexPathForCellElement:btn];
    SJJoke *joke=[self.jokeService.jokes safeObjectAtIndex:indexPath.row];
    
    if (!joke.liked) {
        joke.liked=YES;
        joke.likeCount++;
        [self.mainView.detailTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(void)share:(UIButton *)btn{
    NSIndexPath *indexPath=[self.mainView.detailTableView indexPathForCellElement:btn];
    SJJoke *joke=[self.jokeService.jokes safeObjectAtIndex:indexPath.row];
    joke.shareCount++;
    [self.mainView.detailTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    NSString *content=[NSString stringWithFormat:@"%@ --来自xxx",joke.content];
    
    SJButtonActionSheet *actionSheet=[[SJButtonActionSheet alloc]initWithTitle:@""];
    
    [actionSheet addButtonWithTitle:@"复制内容" image:[UIImage imageNamed:@"更多_复制链接"] block:^{
        [MobClick event:@"02-03"];
        UIPasteboard *pb=[UIPasteboard generalPasteboard];
        [pb setString:content];
    }];
    
    if ([WXApi isWXAppInstalled]) {
        [actionSheet addButtonWithTitle:@"微信好友" image:[UIImage imageNamed:@"更多_icon_微信"] block:^{
            [SJShareCenter shareTo:ShareTypeWeixiSession url:nil content:content];
        }];
        
        [actionSheet addButtonWithTitle:@"朋友圈" image:[UIImage imageNamed:@"更多_icon_朋友圈"] block:^{
            [SJShareCenter shareTo:ShareTypeWeixiTimeline url:nil content:content];
        }];
    }
    
    if ([QQApi isQQInstalled]) {
        [actionSheet addButtonWithTitle:@"QQ" image:[UIImage imageNamed:@"更多_icon_QQ空间"] block:^{
            [SJShareCenter shareTo:ShareTypeQQ url:nil content:content];
        }];
    }
    
    [actionSheet showInView:nil];

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
        [cell.likeBtn addTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
        [cell.shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    SJJoke *joke=[self.jokeService.jokes safeObjectAtIndex:indexPath.row];
    [cell loadJoke:joke];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SJJoke *joke=[self.jokeService.jokes safeObjectAtIndex:indexPath.row];
    return [SJJokeCell cellHeightWithJoke:joke];
}

-(void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    [self loadFirstJokeWithCache:SJCacheMethodNone];
}

-(void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    [self loadMoreJoke];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadFirstJokeWithCache:SJCacheMethodFail];
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

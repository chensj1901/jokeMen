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
#import <AVFoundation/AVFoundation.h>
#import <iflyMSC/iflyMSC.h>
#import "SJCommentViewController.h"
#import "SJJokeURLRequest.h"

@interface SJIndexViewController ()<UITableViewDelegate,UITableViewDataSource,PullTableViewDelegate,IFlySpeechSynthesizerDelegate>
@property(nonatomic)SJIndexView *mainView;
@property(nonatomic)SJJokeService *jokeService;
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
@property(nonatomic)IFlySpeechSynthesizer *ifSynthesizer;
@property(nonatomic,weak)SJJoke *speakingJoke;
@end

@implementation SJIndexViewController
-(SJJokeService *)jokeService{
    if (!_jokeService) {
        _jokeService=[[SJJokeService alloc]init];
    }
    return _jokeService;
}

-(AVSpeechSynthesizer *)synthesizer{
    if (!_synthesizer) {
        _synthesizer=[[AVSpeechSynthesizer alloc]init];
    }
    return _synthesizer;
}

-(IFlySpeechSynthesizer *)ifSynthesizer{
    if (!_ifSynthesizer)
    {
        NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"55d42c03"];
        [IFlySpeechUtility createUtility:initString];
        _ifSynthesizer=[IFlySpeechSynthesizer sharedInstance];
        _ifSynthesizer.delegate=self;
        [_ifSynthesizer setParameter:@"100" forKey:[IFlySpeechConstant SPEED]];
        [_ifSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]];
        [_ifSynthesizer setParameter:@" xiaoyan " forKey: [IFlySpeechConstant VOICE_NAME]];
        [_ifSynthesizer setParameter:@"8000" forKey: [IFlySpeechConstant SAMPLE_RATE]];
    }
    return _ifSynthesizer;
}

-(void)loadUI{
    self.navigationItem.title=@"";
    
    self.mainView.detailTableView.delegate=self;
    self.mainView.detailTableView.dataSource=self;
    self.mainView.detailTableView.pullDelegate=self;
    
    [self.parentViewController quicklyCreateRightItemWithTitle:@"随机一组" titleColorHex:@"313746" titleHighlightedColorHex:nil selector:@selector(randomJoke) target:self];
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

-(void)randomJoke{
    self.mainView.detailTableView.pullTableIsRefreshing=YES;
    [self.jokeService loadFirstRandomJokeWithcacheMethod:SJCacheMethodFail success:^{
        if (self.mainView.detailTableView.pullTableIsRefreshing) {
            self.mainView.detailTableView.pullTableIsRefreshing=NO;
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
    [SJJokeURLRequest apiLikeWithNid:joke._id success:^(AFHTTPRequestOperation *op, id dic) {
        
        
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        
    }];
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

-(void)listen:(UIButton *)btn{
    NSIndexPath *indexPath=[self.mainView.detailTableView indexPathForCellElement:btn];
    SJJoke *joke=[self.jokeService.jokes safeObjectAtIndex:indexPath.row];
    
    if ([self.ifSynthesizer isSpeaking]&&self.speakingJoke==joke) {
        [self stopListen];
    }else{
        [self listenJokeWithJoke:joke];
    }
}

-(void)comment:(UIButton *)btn{
    NSIndexPath *indexPath=[self.mainView.detailTableView indexPathForCellElement:btn];
    SJJoke *joke=[self.jokeService.jokes safeObjectAtIndex:indexPath.row];
    
    SJCommentViewController *commentVC=[[SJCommentViewController alloc]init];
    commentVC.joke=joke;
    [self.navigationController pushViewController:commentVC animated:YES];

}

-(void)stopListen{
    self.speakingJoke=nil;
    [self.ifSynthesizer stopSpeaking];
    [self.mainView.detailTableView reloadData];
}

-(void)listenJokeWithJoke:(SJJoke*)joke{
    if (joke) {
        self.speakingJoke=joke;
        
        NSInteger index=[self.jokeService.jokes getObjectIndexWithBlock:^BOOL(SJJoke* obj) {
            return self.speakingJoke==obj;
        }];
        if (index==[self.jokeService.jokes count]-1) {
            [self pullTableViewDidTriggerLoadMore:self.mainView.detailTableView];
        }
        [self.mainView.detailTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        [self.ifSynthesizer startSpeaking:joke.content];
        [self.mainView.detailTableView reloadData];
    }
}

//合成结束，此代理必须要实现
- (void) onCompleted:(IFlySpeechError *) error{
    if (self.speakingJoke) {
        NSInteger index=[self.jokeService.jokes getObjectIndexWithBlock:^BOOL(SJJoke* obj) {
            return self.speakingJoke==obj;
        }];
        
        
        index++;
        
        SJJoke *joke=[self.jokeService.jokes safeObjectAtIndex:index];
        [self listenJokeWithJoke:joke];
        
    }
}

//合成开始
- (void) onSpeakBegin{
}

//合成缓冲进度
- (void) onBufferProgress:(int) progress message:(NSString *)msg{
}

//合成播放进度
- (void) onSpeakProgress:(int) progress{
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
        [cell.commentBtn addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
        [cell.listenBtn addTarget:self action:@selector(listen:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    SJJoke *joke=[self.jokeService.jokes safeObjectAtIndex:indexPath.row];
    [cell loadJoke:joke isSpeaking:joke==self.speakingJoke];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SJJoke *joke=[self.jokeService.jokes safeObjectAtIndex:indexPath.row];
    return [SJJokeCell cellHeightWithJoke:joke];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self stopListen];
}

-(void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    [self stopListen];
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

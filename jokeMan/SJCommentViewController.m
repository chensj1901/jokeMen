//
//  SJCommentViewController.m
//  jokeMan
//
//  Created by 陈少杰 on 15/8/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJCommentViewController.h"
#import "SJAdsController.h"
#import "SJCommentView.h"
#import "SJJokeURLRequest.h"
#import "SJJokeService.h"
#import "SJCommentCell.h"
#import "SJUserInfo.h"
#import "SJAlertTextFieldView.h"
#import <SJSettingRecode.h>

@interface SJCommentViewController ()<PullTableViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)SJCommentView *mainView;
@property(nonatomic)SJJokeService *jokeService;
@end

@implementation SJCommentViewController
@synthesize mainView=_mainView;

-(SJJokeService *)jokeService{
    if (!_jokeService) {
        _jokeService=[[SJJokeService alloc]init];
    }
    return _jokeService;
}

-(SJCommentView *)mainView{
    if (!_mainView) {
        _mainView=[[SJCommentView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    }
    return _mainView;
}

-(void)loadSetting{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)loadTarget{
    [self.mainView.sendBtn addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
}

-(void)loadUI{
    self.mainView.detailTableView.delegate=self;
    self.mainView.detailTableView.dataSource=self;
    self.mainView.detailTableView.pullDelegate=self;
}

-(void)keyboardWillShow:(id)sender{
    //获取键盘的高度
    NSDictionary *userInfo = [sender userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSInteger height = keyboardRect.size.height;
    
    [self fitSizeWithKeyBroadHeight:height];
}

-(void)keyboardWillHide:(id)sender{
    //获取键盘的高度
    [self fitSizeWithKeyBroadHeight:0];
}

-(void)sendComment{
    if ([SJUserInfo sharedUserInfo].username.length==0) {
        [SJAlertTextFieldView showInViewWithTitle:@"皇上，臣妾想知道你的名字" successBlock:^(UIView *thisView) {
            SJAlertTextFieldView *t=thisView;
            if (t.contentTextField.text.length>0) {
                [SJSettingRecode set:@"username" value:t.contentTextField.text];
                [self sendComment];
            }
        }];
    }else {
        if (self.mainView.contentTextField.text.length>0) {
            [self.mainView.contentTextField resignFirstResponder];
            SJComment *comment=[[SJComment alloc]init];
            comment.username=[SJUserInfo sharedUserInfo].username;
            comment.content=self.mainView.contentTextField.text;
            [self.jokeService.comments insertObject:comment atIndex:0];
            [self.mainView.detailTableView reloadData];
            
            [SJJokeURLRequest apiSendCommentWithUsername:[SJUserInfo sharedUserInfo].username content:self.mainView.contentTextField.text nid:self.joke._id success:^(AFHTTPRequestOperation *op, id dic) {
            } failure:^(AFHTTPRequestOperation *op, NSError *error) {
                
            }];
        }else{
            alert(@"请输入评论内容");
        }
    }
}

-(void)fitSizeWithKeyBroadHeight:(CGFloat)height
{
    [self.mainView.detailTableView quicklySetHeight:HEIGHT-height-44];
    
    [self.mainView.toolbarView quicklySetOriginY:HEIGHT-height-44];
    
}

-(void)loadFirstCommentWithCacheMethod:(SJCacheMethod)cacheMethod{
    [self.jokeService loadFirstCommentWithCacheMethod:cacheMethod nid:self.joke._id success:^{
        if (cacheMethod!=SJCacheMethodOnlyCache&&self.mainView.detailTableView.pullTableIsRefreshing) {
            self.mainView.detailTableView.pullTableIsRefreshing=NO;
        }
        [self.mainView.detailTableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}

-(void)loadMoreComment{
    [self.jokeService loadMoreJokeWithSuccess:^{
        
        if (self.mainView.detailTableView.pullTableIsLoadingMore) {
            self.mainView.detailTableView.pullTableIsLoadingMore=NO;
        }
        [self.mainView.detailTableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"SJCommentCell";
    SJCommentCell *cell=[self.mainView.detailTableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[SJCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    SJComment *comment=[self.jokeService.comments safeObjectAtIndex:indexPath.row];
    [cell loadComment:comment];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SJComment *comment=[self.jokeService.comments safeObjectAtIndex:indexPath.row];
    return [SJCommentCell cellHeightForComment:comment];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.jokeService.comments count];
}

-(void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    [self loadFirstCommentWithCacheMethod:SJCacheMethodFail];
}

-(void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    [self loadMoreComment];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadFirstCommentWithCacheMethod:SJCacheMethodOnlyCache];
    [self loadFirstCommentWithCacheMethod:SJCacheMethodNone];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [SJAdsController removeAdsBanner];
}

-(void)viewWillDisappear:(BOOL)animated{
    [SJAdsController showAdsBanner];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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

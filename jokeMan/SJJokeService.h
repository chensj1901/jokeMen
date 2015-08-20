//
//  SJJokeService.h
//  jokeMan
//
//  Created by 陈少杰 on 15/8/13.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJService.h"
#import "SJJoke.h"
#import "SJComment.h"
#import "SJURLRequestMethodDefined.h"

@interface SJJokeService : SJService
@property(nonatomic)NSMutableArray *jokes;
@property(nonatomic)NSMutableArray *comments;

-(void)loadFirstRandomJokeWithcacheMethod:(SJCacheMethod)cacheMethod success:(SJServiceSuccessBlock) success fail:(SJServiceFailBlock)fail;

-(void)loadFirstJokeWithcacheMethod:(SJCacheMethod)cacheMethod success:(SJServiceSuccessBlock) success fail:(SJServiceFailBlock)fail;

-(void)loadMoreJokeWithSuccess:(SJServiceSuccessBlock) success fail:(SJServiceFailBlock)fail;


-(void)loadFirstCommentWithCacheMethod:(SJCacheMethod)cacheMethod nid:(NSInteger)nid success:(SJServiceSuccessBlock) success fail:(SJServiceFailBlock)fail;

-(void)loadMoreCommentWithSuccess:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail;
@end


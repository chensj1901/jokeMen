//
//  SJJokeService.h
//  jokeMan
//
//  Created by 陈少杰 on 15/8/13.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJService.h"
#import "SJJoke.h"
#import "SJURLRequestMethodDefined.h"

@interface SJJokeService : SJService
@property(nonatomic)NSMutableArray *jokes;
-(void)loadFirstJokeWithcacheMethod:(SJCacheMethod)cacheMethod success:(SJServiceSuccessBlock) success fail:(SJServiceFailBlock)fail;

-(void)loadMoreJokeWithSuccess:(SJServiceSuccessBlock) success fail:(SJServiceFailBlock)fail;
@end

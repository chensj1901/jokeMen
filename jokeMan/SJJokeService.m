//
//  SJJokeService.m
//  jokeMan
//
//  Created by 陈少杰 on 15/8/13.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJJokeService.h"
#import "SJJokeURLRequest.h"
#import <SJSettingRecode.h>

@interface SJJokeService ()


@end

@implementation SJJokeService
{
    NSTimeInterval _timeInterval;
    NSInteger _page;
    NSInteger _nid;
}

-(NSMutableArray *)jokes{
    if (!_jokes) {
        _jokes=[[NSMutableArray alloc]init];
//        for (int i=0; i<100; i++) {
//            SJJoke *joke=[[SJJoke alloc]initWithTest];
//            [_jokes addObject:joke];
//        }
    }
    return _jokes;
}

-(NSMutableArray *)comments{
    if (!_comments) {
        _comments=[[NSMutableArray alloc]init];
    }
    return _comments;
}


-(void)loadFirstRandomJokeWithcacheMethod:(SJCacheMethod)cacheMethod success:(SJServiceSuccessBlock) success fail:(SJServiceFailBlock)fail{
    _page=1;
    _timeInterval=[[NSDate date]timeIntervalSince1970]-arc4random()%(int)(180*24*3600);
    NSTimeInterval time=_timeInterval;

    [SJJokeURLRequest apiLoadJokeWithPage:_page time:time cacheMethod:cacheMethod success:^(AFHTTPRequestOperation *op, id dic) {
        [self.jokes removeAllObjects];
        for (NSDictionary *dictionary in [dic objectForKey:@"jokes"]) {
            SJJoke *joke=[[SJJoke alloc]initWithRemoteDictionary:dictionary];
            [self.jokes addObject:joke];
        }
        _page++;
        if (success) {
            success();
        }
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

-(void)loadFirstJokeWithcacheMethod:(SJCacheMethod)cacheMethod success:(SJServiceSuccessBlock) success fail:(SJServiceFailBlock)fail{
    _page=1;
    _timeInterval=[[NSDate date]timeIntervalSince1970];
    NSTimeInterval time;
    if (cacheMethod==SJCacheMethodOnlyCache) {
        time=[[SJSettingRecode getSet:@"jokeTimeCache"]doubleValue];
    }else{
        time=_timeInterval;
    }
    [SJJokeURLRequest apiLoadJokeWithPage:_page time:time cacheMethod:cacheMethod success:^(AFHTTPRequestOperation *op, id dic) {
        [self.jokes removeAllObjects];
        for (NSDictionary *dictionary in [dic objectForKey:@"jokes"]) {
            SJJoke *joke=[[SJJoke alloc]initWithRemoteDictionary:dictionary];
            [self.jokes addObject:joke];
        }
        [SJSettingRecode set:@"jokeTimeCache" value:[NSString stringWithFormat:@"%f",time]];
        _page++;
        if (success) {
            success();
        }
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

-(void)loadMoreJokeWithSuccess:(SJServiceSuccessBlock) success fail:(SJServiceFailBlock)fail{
    [SJJokeURLRequest apiLoadJokeWithPage:_page time:_timeInterval cacheMethod:SJCacheMethodFail success:^(AFHTTPRequestOperation *op, id dic) {
        _page++;
        for (NSDictionary *dictionary in [dic objectForKey:@"jokes"]) {
            SJJoke *joke=[[SJJoke alloc]initWithRemoteDictionary:dictionary];
            [self.jokes addObject:joke];
        }
        if (success) {
            success();
        }
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        if (fail) {
            fail(error);
        }
        
    }];
}

-(void)loadFirstCommentWithCacheMethod:(SJCacheMethod)cacheMethod nid:(NSInteger)nid success:(SJServiceSuccessBlock) success fail:(SJServiceFailBlock)fail{
    
    _page=1;
    _nid=nid;
    
    [SJJokeURLRequest apiLoadCommentWithPage:_page nid:_nid cacheMethod:cacheMethod success:^(AFHTTPRequestOperation *op, id dic) {
        [self.comments removeAllObjects];
        for (NSDictionary *dictionary in [dic objectForKey:@"comments"]) {
            SJComment *joke=[[SJComment alloc]initWithRemoteDictionary:dictionary];
            [self.comments addObject:joke];
        };
        _page++;
        if (success) {
            success();
        }
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

-(void)loadMoreCommentWithSuccess:(SJServiceSuccessBlock)success fail:(SJServiceFailBlock)fail{
    [SJJokeURLRequest apiLoadCommentWithPage:_page nid:_nid cacheMethod:SJCacheMethodFail success:^(AFHTTPRequestOperation *op, id dic) {
        for (NSDictionary *dictionary in [dic objectForKey:@"jokes"]) {
            SJComment *joke=[[SJComment alloc]initWithRemoteDictionary:dictionary];
            [self.comments addObject:joke];
        };
        _page++;
        if (success) {
            success();
        }
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

@end

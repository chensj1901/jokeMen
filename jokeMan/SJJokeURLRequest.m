//
//  SJJokeURLRequest.m
//  jokeMan
//
//  Created by 陈少杰 on 15/8/18.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJJokeURLRequest.h"

@implementation SJJokeURLRequest
+(void)apiLoadJokeWithPage:(NSInteger)page time:(NSTimeInterval)time cacheMethod:(SJCacheMethod)cacheMethod success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    NSString *url=[NSString stringWithFormat:@"http://1.jhwg.sinaapp.com/gaoxiao/op.php?op=getContent&page=%ld&time=%ld",(long)page,(long)time];
    
    SJHTTPRequestOperationManager *manager=[SJHTTPRequestOperationManager  manager];
    [manager GET:url parameters:nil cacheMethod:cacheMethod success:success failure:failure];
    
}
@end

//
//  SJJokeURLRequest.m
//  jokeMan
//
//  Created by 陈少杰 on 15/8/18.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJJokeURLRequest.h"

//#define HOST_SITE @"http://1.jhwg.sinaapp.com/gaoxiao"
#define HOST_SITE @"http://localhost/jhwg/1/gaoxiao"

@implementation SJJokeURLRequest
+(void)apiLoadJokeWithPage:(NSInteger)page time:(NSTimeInterval)time cacheMethod:(SJCacheMethod)cacheMethod success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    NSString *url=[NSString stringWithFormat:@"%@/op.php?op=getContent&page=%ld&time=%ld",HOST_SITE,(long)page,(long)time];
    
    SJHTTPRequestOperationManager *manager=[SJHTTPRequestOperationManager  manager];
    [manager GET:url parameters:nil cacheMethod:cacheMethod success:success failure:failure];
    
}

+(void)apiLoadCommentWithPage:(NSInteger)page nid:(NSInteger)nid cacheMethod:(SJCacheMethod)cacheMethod success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    NSString *url=[NSString stringWithFormat:@"%@/op.php?op=getComment&page=%ld&nid=%ld",HOST_SITE,(long)page,(long)nid];
    
    SJHTTPRequestOperationManager *manager=[SJHTTPRequestOperationManager  manager];
    [manager GET:url parameters:nil cacheMethod:cacheMethod success:success failure:failure];
    
}

+(void)apiLoadOneJokeWithSuccess:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    NSString *url=[NSString stringWithFormat:@"%@/op.php?op=getOne",HOST_SITE];
    
    SJHTTPRequestOperationManager *manager=[SJHTTPRequestOperationManager  manager];
    [manager GET:url parameters:nil cacheMethod:SJCacheMethodNone success:success failure:failure];
    
}
+(void)apiSendCommentWithUsername:(NSString *)username content:(NSString *)content nid:(NSInteger)nid success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    NSString *url=[NSString stringWithFormat:@"%@/op.php?op=comment",HOST_SITE];
    NSDictionary *data=@{@"nid":@(nid),@"content":content,@"username":username};
    SJHTTPRequestOperationManager *manager=[SJHTTPRequestOperationManager  manager];
    [manager POST:url parameters:data cacheMethod:SJCacheMethodNone success:success failure:failure];
}
+(void)apiLikeWithNid:(NSInteger)nid success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    NSString *url=[NSString stringWithFormat:@"%@/op.php?op=like&nid=%ld",HOST_SITE,(long)nid];

    SJHTTPRequestOperationManager *manager=[SJHTTPRequestOperationManager  manager];
    [manager POST:url parameters:nil cacheMethod:SJCacheMethodNone success:success failure:failure];
}
@end

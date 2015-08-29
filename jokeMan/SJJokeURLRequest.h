//
//  SJJokeURLRequest.h
//  jokeMan
//
//  Created by 陈少杰 on 15/8/18.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJHTTPRequestOperationManager.h"

@interface SJJokeURLRequest : SJHTTPRequestOperationManager
+(void)apiLoadJokeWithPage:(NSInteger)page time:(NSTimeInterval)time cacheMethod:(SJCacheMethod)cacheMethod success:(void (^)(AFHTTPRequestOperation *op, id dic))success failure:(void (^)(AFHTTPRequestOperation *op, NSError *error))failure;
+(void)apiLoadCommentWithPage:(NSInteger)page nid:(NSInteger)nid cacheMethod:(SJCacheMethod)cacheMethod success:(void (^)(AFHTTPRequestOperation *op, id dic))success failure:(void (^)(AFHTTPRequestOperation *op, NSError *error))failure;
+(void)apiLoadOneJokeWithSuccess:(void (^)(AFHTTPRequestOperation *op, id dic))success failure:(void (^)(AFHTTPRequestOperation *op, NSError *error))failure;
+(void)apiSendCommentWithUsername:(NSString *)username content:(NSString *)comment nid:(NSInteger)nid success:(void (^)(AFHTTPRequestOperation *op, id dic))success failure:(void (^)(AFHTTPRequestOperation *op, NSError *error))failure;
+(void)apiLikeWithNid:(NSInteger)nid success:(void (^)(AFHTTPRequestOperation *op, id dic))success failure:(void (^)(AFHTTPRequestOperation *op, NSError *error))failure;
+(void)apiShareWithNid:(NSInteger)nid success:(void (^)(AFHTTPRequestOperation *op, id dic))success failure:(void (^)(AFHTTPRequestOperation *op, NSError *error))failure;

@end

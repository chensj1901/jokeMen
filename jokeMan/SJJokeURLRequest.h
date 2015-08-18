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
@end

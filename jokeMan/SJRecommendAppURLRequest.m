//
//  SJRecommendAppURLRequest.m
//  Yunpan
//
//  Created by 陈少杰 on 15/8/5.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJRecommendAppURLRequest.h"

@implementation SJRecommendAppURLRequest
+(void)apiQueryAppLinkWithSuccess:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    @try {
        SJHTTPRequestOperationManager *manager=[SJHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
        [manager GET:@"http://1.jhwg.sinaapp.com/myAppList.php" parameters:nil cacheMethod:SJCacheMethodFail success:success failure:failure];
    }
    @catch (NSException *exception) {
        if (failure) {
            NSError *error=[NSError errorWithDomain:@"Error" code:404 userInfo:nil];
            failure(nil,error);
        }
    }
    @finally {
        
    }
}
@end

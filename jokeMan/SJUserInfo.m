//
//  SJUserInfo.m
//  jokeMan
//
//  Created by 陈少杰 on 15/8/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJUserInfo.h"
#import <SJSettingRecode.h>

static SJUserInfo *_sharedUserInfo;

@implementation SJUserInfo
+(SJUserInfo *)sharedUserInfo{
    if (!_sharedUserInfo) {
        _sharedUserInfo=[[SJUserInfo alloc]init];

    }
    _sharedUserInfo.username=[SJSettingRecode getSet:@"username"]?[SJSettingRecode getSet:@"username"]:@"";
    return _sharedUserInfo;
}

@end

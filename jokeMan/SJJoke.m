//
//  SJJoke.m
//  jokeMan
//
//  Created by 陈少杰 on 15/8/13.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJJoke.h"
#import <SJSettingRecode.h>

@implementation SJJoke
-(id)initWithRemoteDictionary:(NSDictionary *)dictionary{
    self=[self init];
    if (self) {
        __id = [[dictionary objectForKey:@"id"]integerValue];
        _username = [dictionary objectForKey:@"username"];
        _content = [dictionary objectForKey:@"content"];
        _likeCount = [[dictionary objectForKey:@"likeCount"]integerValue];
        _shareCount = [[dictionary objectForKey:@"shareCount"]integerValue];
        _time = [[dictionary objectForKey:@"time"]integerValue];
    }
    return self;
}

-(id)initWithTest{
    self=[self init];
    if (self) {
        __id = arc4random()%9999;
        _username = @"Tom";
        _content = @"你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅你好帅";
        _likeCount = 99999;
        _shareCount = 88888;
        _time = [[NSDate date]timeIntervalSince1970];
    }
    return self;
}

-(BOOL)liked{
    return [[SJSettingRecode getSet:[NSString stringWithFormat:@"like_%ld",self._id]]boolValue];
}

-(void)setLiked:(BOOL)liked{
    if (liked) {
        [SJSettingRecode set:[NSString stringWithFormat:@"like_%ld",self._id] value:@"1"];
    }else{
        [SJSettingRecode set:[NSString stringWithFormat:@"like_%ld",self._id] value:@"0"];
    }
}


@end

//
//  SJComment.m
//  jokeMan
//
//  Created by 陈少杰 on 15/8/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJComment.h"

@implementation SJComment

-(id)initWithRemoteDictionary:(NSDictionary *)dictionary{
    self=[self init];
    if (self) {
        __id = [[dictionary objectForKey:@"_id"]integerValue];
        _username = [dictionary objectForKey:@"username"];
        _content = [dictionary objectForKey:@"content"];
    }
    return self;
}

@end

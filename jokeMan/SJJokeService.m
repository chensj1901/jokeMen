//
//  SJJokeService.m
//  jokeMan
//
//  Created by 陈少杰 on 15/8/13.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJJokeService.h"

@implementation SJJokeService
-(NSMutableArray *)jokes{
    if (!_jokes) {
        _jokes=[[NSMutableArray alloc]init];
        for (int i=0; i<100; i++) {
            SJJoke *joke=[[SJJoke alloc]initWithTest];
            [_jokes addObject:joke];
        }
    }
    return _jokes;
}
@end

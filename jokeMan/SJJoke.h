//
//  SJJoke.h
//  jokeMan
//
//  Created by 陈少杰 on 15/8/13.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJJoke : NSObject
/**
 *	@brief
 */
@property(nonatomic,readonly)NSInteger id;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSString *username;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSString *content;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSInteger likeCount;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSInteger shareCount;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSTimeInterval time;

-(id)initWithRemoteDictionary:(NSDictionary *)dictionary;

-(id)initWithTest;
@end

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
@property(nonatomic,readonly)NSInteger _id;

/**
 *	@brief
 */
@property(nonatomic)NSString *username;

/**
 *	@brief
 */
@property(nonatomic)NSString *content;

/**
 *	@brief
 */
@property(nonatomic)NSInteger likeCount;

/**
 *	@brief
 */
@property(nonatomic)NSInteger shareCount;

/**
 *	@brief
 */
@property(nonatomic)NSInteger commentCount;

/**
 *	@brief
 */
@property(nonatomic,readonly)NSTimeInterval time;

@property(nonatomic)BOOL liked;

-(id)initWithRemoteDictionary:(NSDictionary *)dictionary;

-(id)initWithTest;
@end

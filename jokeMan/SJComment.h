//
//  SJComment.h
//  jokeMan
//
//  Created by 陈少杰 on 15/8/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJComment : NSObject

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

-(id)initWithRemoteDictionary:(NSDictionary *)dictionary;

@end

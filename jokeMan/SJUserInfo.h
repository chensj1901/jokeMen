//
//  SJUserInfo.h
//  jokeMan
//
//  Created by 陈少杰 on 15/8/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJUserInfo : NSObject
+(SJUserInfo *)sharedUserInfo;
@property(nonatomic)NSString *username;
@end

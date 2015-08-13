//
//  SJService.h
//  Yunpan
//
//  Created by 陈少杰 on 15/8/3.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//
#import "SJURLRequestMethodDefined.h"

typedef void(^SJServiceSuccessBlock)(void);
typedef void(^SJServiceFailBlock)(NSError *error);

@interface SJService : NSObject

@end

//
//  SJCommentCell.h
//  jokeMan
//
//  Created by 陈少杰 on 15/8/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJCell.h"
#import "SJComment.h"

@interface SJCommentCell : SJCell
@property(nonatomic,readonly)UILabel *usernameLabel;
@property(nonatomic,readonly)UILabel *contentLabel;
@property(nonatomic,readonly)UIView *lineView;

-(void)loadComment:(SJComment*)comment;
+(CGFloat)cellHeightForComment:(SJComment*)comment;
@end

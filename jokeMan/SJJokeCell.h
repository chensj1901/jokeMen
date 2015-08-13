//
//  SJJokeCell.h
//  jokeMan
//
//  Created by 陈少杰 on 15/8/13.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJCell.h"
#import "SJJoke.h"

@interface SJJokeCell : SJCell
@property(nonatomic,readonly)UIImageView *titleImageView;
@property(nonatomic,readonly)UILabel *usernameLabel;
@property(nonatomic,readonly)UILabel *timeLabel;
@property(nonatomic,readonly)UILabel *contentLabel;
@property(nonatomic,readonly)UIView *bottomView;
@property(nonatomic,readonly)UIButton *likeBtn;
@property(nonatomic,readonly)UIButton *shareBtn;
@property(nonatomic,readonly)UIView *lineOneView;
@property(nonatomic,readonly)UIView *lineTwoView;

+(CGFloat)cellHeightWithJoke:(SJJoke *)joke;
-(void)loadJoke:(SJJoke *)joke;
@end

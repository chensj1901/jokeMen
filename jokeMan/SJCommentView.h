//
//  SJCommentView.h
//  jokeMan
//
//  Created by 陈少杰 on 15/8/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "SJTextField.h"

@interface SJCommentView : UIView
@property(nonatomic,readonly)PullTableView *detailTableView;
@property(nonatomic,readonly)UIView *toolbarView;
@property(nonatomic,readonly)SJTextField *contentTextField;
@property(nonatomic,readonly)UIButton *sendBtn;
@end

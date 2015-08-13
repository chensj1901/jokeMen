//
//  SJRecommendAppView.m
//  zhitu
//
//  Created by 陈少杰 on 13-11-29.
//  Copyright (c) 2013年 聆创科技有限公司. All rights reserved.
//

#import "SJRecommendAppView.h"

@implementation SJRecommendAppView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self loadUI];
    }
    return self;
}

-(void)loadUI{
    self.backgroundColor=[UIColor colorWithRed:0.98 green:0.99 blue:0.99 alpha:1.00];
    [self addSubview:self.appsTableView];
}

-(PullTableView *)appsTableView{
    if (!_appsTableView) {
        _appsTableView=[[PullTableView alloc]initWithFrame:self.bounds loadMoreSwitch:YES refreshSwitch:NO];
        _appsTableView.backgroundColor=[UIColor clearColor];
    }
    return _appsTableView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

//
//  SJCommentView.m
//  jokeMan
//
//  Created by 陈少杰 on 15/8/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJCommentView.h"

@implementation SJCommentView
{
    CGRect _detailTableViewRect;
    CGRect _toolbarViewRect;
    CGRect _contentTextFieldRect;
    CGRect _sendBtnRect;
}



@synthesize detailTableView=_detailTableView;
@synthesize toolbarView=_toolbarView;
@synthesize contentTextField=_contentTextField;
@synthesize sendBtn=_sendBtn;



#pragma mark - 初始化

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _detailTableViewRect= CGRectMake(0, 0, SELF_WIDTH, SELF_HEIGHT);
    _toolbarViewRect= CGRectMake(0, SELF_HEIGHT-44, SELF_WIDTH, 44);
    _contentTextFieldRect= CGRectMake(5, 7, WIDTH-65, 30);
    _sendBtnRect= CGRectMake(WIDTH-55, 7, 50, 30);
}

-(void)loadUI{
    self.backgroundColorHex=@"ffffff";
    [self addSubview:self.detailTableView];
    [self addSubview:self.toolbarView];
    [self.toolbarView addSubview:self.contentTextField];
    [self.toolbarView addSubview:self.sendBtn];
}

#pragma mark - 属性定义


-(PullTableView *)detailTableView{
    if (!_detailTableView) {
        _detailTableView=[[PullTableView alloc]initWithFrame:_detailTableViewRect loadMoreSwitch:YES refreshSwitch:NO];
    }
    return _detailTableView;
}


-(UIView *)toolbarView{
    if (!_toolbarView) {
        UIImageView *b=[[UIImageView alloc]initWithFrame:_toolbarViewRect];
        [b quicklySetBackgroundImageName:@"私聊框底层@2x.png"];
        b.userInteractionEnabled=YES;
        _toolbarView=b;

    }
    return _toolbarView;
}

-(SJTextField *)contentTextField{
    if (!_contentTextField) {
        _contentTextField=[[SJTextField alloc]initWithFrame:_contentTextFieldRect];
        _contentTextField.background=[[UIImage imageNamed:@"聊天框.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(15.5, 20.5, 15.5, 20.5)];
        _contentTextField.horizontalPadding=10;
    }
    return _contentTextField;
}

-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.frame=_sendBtnRect;
        [_sendBtn quicklySetFontPoint:14 textColorHex:@"313746" textAlignment:NSTextAlignmentCenter title:@"发送"];
    }
    return _sendBtn;
}



#pragma mark - 其他方法
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  SJTabSwitchView.m
//  tBook
//
//  Created by 陈少杰 on 15/2/7.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJTabSwitchView.h"

@implementation SJTabSwitchView
{
    CGRect _indexBtnRect;
    CGRect _settingBtnRect;
    CGRect _messageBtnRect;
    CGRect _profileBtnRect;
    CGRect _backgroundViewRect;
    CGRect _lineViewRect;
}


@synthesize indexBtn=_indexBtn;
@synthesize settingBtn=_settingBtn;
@synthesize backgroundView=_backgroundView;
@synthesize lineView=_lineView;



#pragma mark - 初始化

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _backgroundViewRect= CGRectMake((WIDTH-120)/2, 7, 120, 30);
    _lineViewRect= CGRectMake(60, 0, 0.5, CGRectGetHeight(_backgroundViewRect));
    _indexBtnRect= CGRectMake(0, 0, 60, CGRectGetHeight(_backgroundViewRect));
    _settingBtnRect= CGRectMake(60, 0, 60, CGRectGetHeight(_backgroundViewRect));
}

-(void)loadUI{
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.lineView];
    [self.backgroundView addSubview:self.indexBtn];
    [self.backgroundView addSubview:self.settingBtn];
}

#pragma mark - 属性定义

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]initWithFrame:_lineViewRect];
        _lineView.backgroundColor=[UIColor colorWithHex:@"cccccc"];
    }
    return _lineView;
}

-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView=[[UIView alloc]initWithFrame:_backgroundViewRect];
        _backgroundView.backgroundColorHex=@"F8F8F8";
        _backgroundView.layer.borderWidth=1;
        _backgroundView.layer.borderColor=[[UIColor colorWithHex:@"cccccc"]CGColor];
        _backgroundView.layer.cornerRadius=4;
    }
    return _backgroundView;
}


-(UIButton *)indexBtn{
    if (!_indexBtn) {
        _indexBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _indexBtn.frame=_indexBtnRect;
        [_indexBtn quicklySetFontPoint:14 textAlignment:NSTextAlignmentCenter title:@"主页"];
        [_indexBtn quicklySetNormalTextColorHex:@"cccccc" highlightedTextColorHex:@"313746" selectedTextColorHex:@"313746"];
    }
    return _indexBtn;
}

-(UIButton *)settingBtn{
    if (!_settingBtn) {
        _settingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _settingBtn.frame=_settingBtnRect;
        [_settingBtn quicklySetFontPoint:14 textAlignment:NSTextAlignmentCenter title:@"更多"];
        [_settingBtn quicklySetNormalTextColorHex:@"cccccc" highlightedTextColorHex:@"313746" selectedTextColorHex:@"313746"];
    }
    return _settingBtn;
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

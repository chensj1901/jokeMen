//
//  SJJokeCell.m
//  jokeMan
//
//  Created by 陈少杰 on 15/8/13.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJJokeCell.h"

@implementation SJJokeCell

{
    CGRect _titleImageViewRect;
    CGRect _usernameLabelRect;
    CGRect _timeLabelRect;
    CGRect _contentLabelRect;
    CGRect _likeBtnRect;
    CGRect _shareBtnRect;
    CGRect _lineOneViewRect;
    CGRect _lineTwoViewRect;
    CGRect _lineThreeViewRect;
    CGRect _bottomViewRect;
    CGRect _listenBtnRect;
    CGRect _lineBottomViewRect;
    CGRect _commentBtnRect;
}


@synthesize titleImageView=_titleImageView;
@synthesize usernameLabel=_usernameLabel;
@synthesize timeLabel=_timeLabel;
@synthesize contentLabel=_contentLabel;
@synthesize likeBtn=_likeBtn;
@synthesize shareBtn=_shareBtn;
@synthesize commentBtn=_commentBtn;
@synthesize lineOneView=_lineOneView;
@synthesize lineTwoView=_lineTwoView;
@synthesize lineThreeView=_lineThreeView;
@synthesize bottomView=_bottomView;
@synthesize listenBtn=_listenBtn;
@synthesize lineBottomView=_lineBottomView;


#pragma mark - 初始化

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}



-(void)loadSetting{
    CGFloat bBtnWidth=(WIDTH-14)/3;
    CGFloat sBtnWidth=bBtnWidth*2/3;
    _titleImageViewRect= CGRectMake(7, 7, WIDTH-14, 30);
    _usernameLabelRect= CGRectMake(7, 0, (WIDTH-28)/2, 30);
    _timeLabelRect= CGRectMake((WIDTH-28)/2+7, 0, (WIDTH-28)/2, 30);
    _contentLabelRect= CGRectMake(7, 30, CGRectGetWidth(_titleImageViewRect)-14, 0);
    _bottomViewRect= CGRectMake(0, 0, (WIDTH-28), 40);
    _likeBtnRect= CGRectMake(0, 0,  sBtnWidth, 40);
    _shareBtnRect= CGRectMake(sBtnWidth, 0,  sBtnWidth, 40);
    _commentBtnRect= CGRectMake(sBtnWidth*2, 0,  sBtnWidth, 40);
    _listenBtnRect= CGRectMake(bBtnWidth*2, 0, bBtnWidth , 40);
    _lineOneViewRect= CGRectMake(sBtnWidth-0.5, 0, 0.5, 40);
    _lineTwoViewRect= CGRectMake(sBtnWidth*2-0.5, 0, 0.5, 40);
    _lineThreeViewRect= CGRectMake(sBtnWidth*3-0.5, 0, 0.5, 40);
    _lineBottomViewRect=CGRectMake(0, 0, WIDTH-14, 0.5);
}

-(void)loadUI{
    [self addSubview:self.titleImageView];
    [self.titleImageView addSubview:self.usernameLabel];
    [self.titleImageView addSubview:self.timeLabel];
    [self.titleImageView addSubview:self.contentLabel];
    [self.titleImageView addSubview:self.bottomView];
    [self.bottomView addSubview:self.likeBtn];
    [self.bottomView addSubview:self.shareBtn];
    [self.bottomView addSubview:self.commentBtn];
    [self.bottomView addSubview:self.listenBtn];
    [self.bottomView addSubview:self.lineOneView];
    [self.bottomView addSubview:self.lineTwoView];
    [self.bottomView addSubview:self.lineThreeView];
    [self.bottomView addSubview:self.lineBottomView];
}

#pragma mark - 属性定义

-(UIImageView *)titleImageView{
    if (!_titleImageView) {
        _titleImageView=[[UIImageView alloc]initWithFrame:_titleImageViewRect];
        [_titleImageView quicklySetBackgroundImageName:@"频道bg.png"];
        _titleImageView.userInteractionEnabled=YES;
    }
    return _titleImageView;
}

-(UILabel *)usernameLabel{
    if (!_usernameLabel) {
        _usernameLabel=[[UILabel alloc]initWithFrame:_usernameLabelRect];
        [_usernameLabel quicklySetFontPoint:13 textColorHex:@"313746" textAlignment:NSTextAlignmentLeft];
    }
    return _usernameLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel=[[UILabel alloc]initWithFrame:_timeLabelRect];
        [_timeLabel quicklySetFontPoint:13 textColorHex:@"313746" textAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[UILabel alloc]initWithFrame:_contentLabelRect];
        [_contentLabel quicklySetFontPoint:14 textColorHex:@"62707d" textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
    }
    return _contentLabel;
}

-(UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _likeBtn.frame=_likeBtnRect;
        [_likeBtn quicklySetNormalImageNamed:@"likeBtn" highlightImageNamed:nil selectedImageNamed:@"likeBtn_s"];
        [_likeBtn quicklySetFontPoint:14 textColorHex:@"62707d" textAlignment:NSTextAlignmentCenter];
    }
    return _likeBtn;
}

-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame=_shareBtnRect;
        [_shareBtn quicklySetNormalImageNamed:@"shareBtn" highlightImageNamed:nil selectedImageNamed:nil];
        [_shareBtn quicklySetFontPoint:14 textColorHex:@"62707d" textAlignment:NSTextAlignmentCenter];
    }
    return _shareBtn;
}
-(UIButton *)commentBtn{
    if (!_commentBtn) {
        _commentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _commentBtn.frame=_commentBtnRect;
        [_commentBtn quicklySetNormalImageNamed:@"commentBtn.png" highlightImageNamed:nil selectedImageNamed:nil];
        [_commentBtn quicklySetFontPoint:14 textColorHex:@"62707d" textAlignment:NSTextAlignmentCenter];
    }
    return _commentBtn;
}

-(UIButton *)listenBtn{
    if (!_listenBtn) {
        _listenBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _listenBtn.frame=_listenBtnRect;
        [_listenBtn quicklySetNormalImageNamed:@"listenBtn" highlightImageNamed:nil selectedImageNamed:@"listenBtn_s"];
        [_listenBtn quicklySetFontPoint:14 textColorHex:@"62707d" textAlignment:NSTextAlignmentCenter title:@"念给朕听"];
        [_listenBtn quicklySetNormalTextColorHex:@"62707d" highlightedTextColorHex:nil selectedTextColorHex:@"FF9C2E"];
    }
    return _listenBtn;
}


-(UIView *)lineOneView{
    if (!_lineOneView) {
        _lineOneView=[[UIView alloc]initWithFrame:_lineOneViewRect];
    _lineOneView.backgroundColorHex=@"eeF0F0";
    }
    return _lineOneView;
}

-(UIView *)lineTwoView{
    if (!_lineTwoView) {
        _lineTwoView=[[UIView alloc]initWithFrame:_lineTwoViewRect];
        _lineTwoView.backgroundColorHex=@"eeF0F0";
    }
    return _lineTwoView;
}

-(UIView *)lineThreeView{
    if (!_lineThreeView) {
        _lineThreeView=[[UIView alloc]initWithFrame:_lineThreeViewRect];
        _lineThreeView.backgroundColorHex=@"eeF0F0";
    }
    return _lineThreeView;
}

-(UIView *)lineBottomView{
    if (!_lineBottomView) {
        _lineBottomView=[[UIView alloc]initWithFrame:_lineBottomViewRect];
        _lineBottomView.backgroundColorHex=@"eeF0F0";
    }
    return _lineBottomView;
}


-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView=[[UIView alloc]initWithFrame:_bottomViewRect];
    }
    return _bottomView;
}



#pragma mark - 其他方法
-(void)loadJoke:(SJJoke *)joke isSpeaking:(BOOL)isSpeaking{
    self.usernameLabel.text=joke.username;
    self.timeLabel.text=[SJFunction dateFormat:joke.time];
    self.contentLabel.text=joke.content;
    self.contentLabel.textColor=isSpeaking?[UIColor colorWithHex:@"FF9C2E"]:[UIColor colorWithHex:@"62707d"];
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)joke.likeCount] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%ld",(long)joke.shareCount] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%ld",(long)joke.commentCount] forState:UIControlStateNormal];
    self.likeBtn.selected=joke.liked;
    [self.likeBtn setTitleColor:[UIColor colorWithHex:@"FF9C2E"] forState:UIControlStateSelected];
    self.listenBtn.selected=isSpeaking;
    
    CGSize contentSize=[SJJokeCell contentHeightForContent:joke.content];
    [self.contentLabel quicklySetHeight:contentSize.height+20];
    [self.titleImageView quicklySetHeight:contentSize.height+90];
    [self.bottomView quicklySetOriginY:CGRectGetMaxY(self.contentLabel.frame)];
}

+(CGFloat)cellHeightWithJoke:(SJJoke *)joke{
    CGSize contentSize=[SJJokeCell contentHeightForContent:joke.content];
    return contentSize.height+97;
}

+(CGSize)contentHeightForContent:(NSString *)content{
    SJJokeCell *cell=[[SJJokeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"testing"];
   return  [content sizeWithFont:cell.contentLabel.font constrainedToSize:CGSizeMake(CGRectGetWidth(cell.contentLabel.bounds), 999) lineBreakMode:cell.contentLabel.lineBreakMode];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

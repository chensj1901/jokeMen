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
    CGRect _bottomViewRect;
}


@synthesize titleImageView=_titleImageView;
@synthesize usernameLabel=_usernameLabel;
@synthesize timeLabel=_timeLabel;
@synthesize contentLabel=_contentLabel;
@synthesize likeBtn=_likeBtn;
@synthesize shareBtn=_shareBtn;
@synthesize lineOneView=_lineOneView;
@synthesize lineTwoView=_lineTwoView;
@synthesize bottomView=_bottomView;


#pragma mark - 初始化

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _titleImageViewRect= CGRectMake(7, 7, WIDTH-14, 30);
    _usernameLabelRect= CGRectMake(7, 0, (WIDTH-28)/2, 30);
    _timeLabelRect= CGRectMake((WIDTH-28)/2+7, 0, (WIDTH-28)/2, 30);
    _contentLabelRect= CGRectMake(7, 30, WIDTH-14, 0);
    _bottomViewRect= CGRectMake(0, 0, (WIDTH-28), 40);
    _likeBtnRect= CGRectMake(7, 0,  (WIDTH-28)/2, 40);
    _shareBtnRect= CGRectMake((WIDTH-28)/2+7, 0,  (WIDTH-28)/2, 40);
    _lineOneViewRect= CGRectMake(WIDTH/2-0.5, 0, 0.5, 40);
    _lineTwoViewRect= CGRectMake(0, 0, WIDTH-14, 0.5);
}

-(void)loadUI{
    [self addSubview:self.titleImageView];
    [self.titleImageView addSubview:self.usernameLabel];
    [self.titleImageView addSubview:self.timeLabel];
    [self.titleImageView addSubview:self.contentLabel];
    [self.titleImageView addSubview:self.bottomView];
    [self.bottomView addSubview:self.likeBtn];
    [self.bottomView addSubview:self.shareBtn];
    [self.bottomView addSubview:self.lineOneView];
    [self.bottomView addSubview:self.lineTwoView];
}

#pragma mark - 属性定义

-(UIImageView *)titleImageView{
    if (!_titleImageView) {
        _titleImageView=[[UIImageView alloc]initWithFrame:_titleImageViewRect];
        [_titleImageView quicklySetBackgroundImageName:@"频道bg.png"];
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
//        [_likeBtn quicklySetNormalImageNamed:<#(NSString *)#> highlightImageNamed:<#(NSString *)#> selectedImageNamed:<#(NSString *)#>];
        [_likeBtn quicklySetFontPoint:14 textColorHex:@"62707d" textAlignment:NSTextAlignmentCenter];
    }
    return _likeBtn;
}

-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame=_shareBtnRect;
//        [_shareBtn quicklySetNormalImageNamed:<#(NSString *)#> highlightImageNamed:<#(NSString *)#> selectedImageNamed:<#(NSString *)#>];
        [_shareBtn quicklySetFontPoint:14 textColorHex:@"62707d" textAlignment:NSTextAlignmentCenter];
    }
    return _shareBtn;
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

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView=[[UIView alloc]initWithFrame:_bottomViewRect];
    }
    return _bottomView;
}



#pragma mark - 其他方法
-(void)loadJoke:(SJJoke *)joke{
    self.usernameLabel.text=joke.username;
    self.timeLabel.text=[SJFunction dateFormat:joke.time];
    self.contentLabel.text=joke.content;
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%d",joke.likeCount] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%d",joke.shareCount] forState:UIControlStateNormal];
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

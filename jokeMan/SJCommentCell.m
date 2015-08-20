//
//  SJCommentCell.m
//  jokeMan
//
//  Created by 陈少杰 on 15/8/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJCommentCell.h"

@implementation SJCommentCell
{
    CGRect _usernameLabelRect;
    CGRect _contentLabelRect;
    CGRect _lineViewRect;
}


@synthesize usernameLabel=_usernameLabel;
@synthesize contentLabel=_contentLabel;
@synthesize lineView=_lineView;


#pragma mark - 初始化

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _lineViewRect= CGRectMake(0, 0, WIDTH, 1);
//    _usernameLabelRect= CGRectMake(7, 5, WIDTH-14, 12);
    _contentLabelRect= CGRectMake(7, 7, WIDTH-14, 30);
}

-(void)loadUI{
    [self addSubview:self.lineView];
//    [self addSubview:self.usernameLabel];
    [self addSubview:self.contentLabel];
}

#pragma mark - 属性定义
//

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]initWithFrame:_lineViewRect];
        _lineView.backgroundColorHex=@"eeeeee";
    }
    return _lineView;
}

-(UILabel *)usernameLabel{
    if (!_usernameLabel) {
        _usernameLabel=[[UILabel alloc]initWithFrame:_usernameLabelRect];
        [_usernameLabel quicklySetFontPoint:14 textColorHex:@"62707d" textAlignment:NSTextAlignmentLeft];
    }
    return _usernameLabel;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[UILabel alloc]initWithFrame:_contentLabelRect];
        [_contentLabel quicklySetFontPoint:14 textColorHex:@"62707d" textAlignment:NSTextAlignmentLeft];
    }
    return _contentLabel;
}



#pragma mark - 其他方法
-(void)loadComment:(SJComment *)comment{
//    self.usernameLabel.text=comment.username;
    NSString *content=[SJCommentCell commentContentWithComment:comment];
    self.contentLabel.text=content;
    
    NSMutableAttributedString *attr=[self.contentLabel.attributedText mutableCopy];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:@"246c97"] range:NSMakeRange(0, comment.username.length)];
    self.contentLabel.attributedText=attr;
    
    CGSize s=[content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(WIDTH-14, 999)];
    [self.contentLabel quicklySetHeight:MAX(s.height, 30)];
    [self.lineView quicklySetOriginY:MAX(s.height+13, 43)];
}

+(NSString *)commentContentWithComment:(SJComment*)comment{
    return [NSString stringWithFormat:@"%@ : %@",comment.username,comment.content];
}

+(CGFloat)cellHeightForComment:(SJComment *)comment{
    CGSize s=[[self commentContentWithComment:comment] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(WIDTH-14, 999)];
    return MAX(s.height+14, 44);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

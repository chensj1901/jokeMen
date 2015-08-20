//
//  SJAlertTextFieldView.m
//  jokeMan
//
//  Created by 陈少杰 on 15/8/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJAlertTextFieldView.h"

@implementation SJAlertTextFieldView
{
CGRect _boxImageViewRect;
CGRect _titleLabelRect;
CGRect _contentTextFieldRect;
CGRect _randomBtnRect;
CGRect _okBtnRect;
CGRect _cancelBtnRect;
}


@synthesize boxImageView=_boxImageView;
@synthesize titleLabel=_titleLabel;
@synthesize contentTextField=_contentTextField;
@synthesize randomBtn=_randomBtn;
@synthesize okBtn=_okBtn;
@synthesize cancelBtn=_cancelBtn;


#pragma mark - 初始化
-(NSString *)getRandomName{
    NSArray *p1,*p2,*p3;
    NSInteger sex=arc4random()%2;
    if (sex==0) {
       p1=@[@"慕容",@"任",@"于",@"厉",@"钟离",@"唐",@"东方",@"敖",@"白",@"南宫",@"竺",@"司徒",@"尉迟",@"司空",@"蓝",@"邵",@"西门",@"颜",@"莫  X:欧阳",@"尚",@"上官"];
        
       p2=@[@"真",@"踏",@"凝",@"竹",@"若",@"雨",@"紫",@"影",@"亦",@"伊",@"羽",@"冰"];
       p3=@[@"菲",@"星",@"悠",@"馨",@"香",@"爱",@"落",@"轩",@"儿",@"萱",@"雪",@"月",@"凌",@"珣",@"痕",@"荫",@"茹",@"忆",@"舞",@"琦  25；汐",@"郁",@"心",@"韵",@" 然",@"嫣"];
    }else{
        p1=@[@"慕容",@"任",@"于",@"厉",@"钟离",@"唐",@"东方",@"敖",@"公孙",@"南宫",@"邵",@"司徒",@"尉迟",@"司空",@"尹",@"明",@"西门",@"归海",@"莫",@"欧阳",@"尚",@"上官"];
        p2=@[@"绝",@"逸",@"寒",@"封",@"萧",@"云",@"燚",@"轩",@"海",@"元",@"天",@"寂"];
    p3=@[@"言",@"洛",@"涯",@"夜",@"痕",@"清",@"尘",@"阳",@"武",@"遥",@"风",@"空",@"竹",@"涵",@"偌",@"语",@"伦",@"滨",@"璘",@"永",@"恒",@"明",@"岚",@"舜",@" 翰",@"遐"];
    }

    NSString *result=[NSString stringWithFormat:@"%@%@%@",[p1 safeObjectAtIndex:arc4random()%[p1 count]],[p2 safeObjectAtIndex:arc4random()%[p2 count]],[p3 safeObjectAtIndex:arc4random()%[p3 count]]];
    return result;
}

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _boxImageViewRect= CGRectMake((WIDTH-240)/2, (WIDTH+88-109)/2, 240, 129);
    _titleLabelRect= CGRectMake(0, 15, CGRectGetWidth(_boxImageViewRect), 14);
    _contentTextFieldRect= CGRectMake(17, 50, CGRectGetWidth(_boxImageViewRect)-59, 30);
    _randomBtnRect= CGRectMake(CGRectGetWidth(_boxImageViewRect)-37, 50, 30, 30);
    _okBtnRect= CGRectMake(23, 95, (CGRectGetWidth(_boxImageViewRect)-46)/2, 20);
    _cancelBtnRect= CGRectMake(CGRectGetWidth(_boxImageViewRect)-(CGRectGetWidth(_boxImageViewRect)-46)/2-23, 95, (CGRectGetWidth(_boxImageViewRect)-46)/2, 20);
}

-(void)loadUI{
    self.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.6];
    
    [self addSubview:self.boxImageView];
    [self.boxImageView addSubview:self.titleLabel];
    [self.boxImageView addSubview:self.contentTextField];
    [self.boxImageView addSubview:self.randomBtn];
    [self.boxImageView addSubview:self.okBtn];
    [self.boxImageView addSubview:self.cancelBtn];
}

#pragma mark - 属性定义

-(UIImageView *)boxImageView{
    if (!_boxImageView) {
        _boxImageView=[[UIImageView alloc]initWithFrame:_boxImageViewRect];
        _boxImageView.backgroundColor=[UIColor whiteColor];
//        [_boxImageView quicklySetBackgroundImageName:@"toast底框_.png"];
        //        UIImage *image = [UIImage imageNamed:@"toast底框_.png"];
        //        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(6, 10, 13, 10)];
        //        _boxImageView.image = image;
        _boxImageView.userInteractionEnabled=YES;
        _boxImageView.layer.cornerRadius=3;
        _boxImageView.layer.masksToBounds=YES;
    }
    return _boxImageView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]initWithFrame:_titleLabelRect];
        [_titleLabel quicklySetFontPoint:14 textColorHex:@"313746" textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(SJTextField *)contentTextField{
    if (!_contentTextField) {
        _contentTextField=[[SJTextField alloc]initWithFrame:_contentTextFieldRect];
        _contentTextField.horizontalPadding=10;
        _contentTextField.background=[[UIImage imageNamed:@"聊天框.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
        [_contentTextField quicklySetFontPoint:12 textColorHex:@"313746" placeHolderColorHex:@"888888" placeHolder:@"" textAlignment:NSTextAlignmentLeft];
    }
    return _contentTextField;
}

-(UIButton *)randomBtn{
    if (!_randomBtn) {
        _randomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _randomBtn.frame=_randomBtnRect;
        [_randomBtn quicklySetNormalImageNamed:@"shazi.png" highlightImageNamed:nil selectedImageNamed:nil];
//        [_randomBtn quicklySetFontPoint:14 textColorHex:@"313746" textAlignment:NSTextAlignmentCenter title:@"随机一个"];
    }
    return _randomBtn;
}


-(UIButton *)okBtn{
    if (!_okBtn) {
        _okBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _okBtn.frame=_okBtnRect;
        [_okBtn quicklySetFontPoint:14 textColorHex:@"313746" textAlignment:NSTextAlignmentLeft title:@"确认"];
    }
    return _okBtn;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame=_cancelBtnRect;
        [_cancelBtn quicklySetFontPoint:14 textColorHex:@"313746" textAlignment:NSTextAlignmentRight title:@"取消"];
    }
    return _cancelBtn;
}

-(void)ok{
    if (self.finishBlock) {
        self.finishBlock(self);
    }
    [self removeFromSuperview];
}

-(void)cancel{
    [self removeFromSuperview];
}

-(void)setRadomName{
    self.contentTextField.text=[self getRandomName];
}

#pragma mark - 其他方法
+(void)showInViewWithTitle:(NSString *)title successBlock:(SJTipViewSuccessBlock_1)successBlock{
    SJAlertTextFieldView *tipView=[[SJAlertTextFieldView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
  
    tipView.titleLabel.text=title;
    
//    CGSize size = [title sizeWithFont:tipView.titleLabel.font];
    
//    CGFloat offset = 23 * ((CGFloat)WIDTH/320);
//    CGFloat width = size.width + offset * 2;
//    if (width < 214) {
//        width = 214;
//    }
//    //    if (width > tipView.boxImageView.frame.size.width)
//    {
//        CGRect boxImageViewRrame = CGRectMake((WIDTH - width)/2, (WIDTH+88-109)/2, width, 125);
//        tipView.boxImageView.frame = boxImageViewRrame;
//        tipView.titleLabel.frame = CGRectMake((width - size.width)*0.5, 21, size.width, 14);
//        tipView.okBtn.frame = CGRectMake(offset, 50+30, (200-(offset*2))/2, 24);
//        tipView.cancelBtn.frame = CGRectMake(CGRectGetWidth(boxImageViewRrame)-(200-(offset*2))/2-offset, 50+30, (200-(offset*2))/2, 24);
//    }
    [tipView setRadomName];
    
    [tipView.okBtn addTarget:tipView action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];

    [tipView.cancelBtn addTarget:tipView action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [tipView.randomBtn addTarget:tipView action:@selector(setRadomName) forControlEvents:UIControlEventTouchUpInside];
    
    tipView.finishBlock=successBlock;
    [[[[UIApplication sharedApplication]windows]objectAtIndex:0]addSubview:tipView];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

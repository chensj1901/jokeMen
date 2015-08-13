//
//  SJButtonActionSheet.m
//  zhitu
//
//  Created by 陈少杰 on 14-1-9.
//  Copyright (c) 2014年 聆创科技有限公司. All rights reserved.
//

#import "SJButtonActionSheet.h"
#import "BlockBackground.h"
#import "SJFrame.h"


#define SJBUTTONWIDTH 60.f


@implementation SJButtonActionSheet
{
    UIImageView *_view;
}

+(id)sheetWithTitle:(NSString *)title{
    id buttonActionSheet=[[[self class] alloc]initWithTitle:title];
    return buttonActionSheet;
}
-(id)initWithTitle:(NSString *)title{
    if (self=[super init]) {
        _view=[[UIImageView alloc]initWithFrame:[BlockBackground sharedInstance].bounds];
        _view.userInteractionEnabled=YES;
        _view.image=[[UIImage imageNamed:@"更多_bg.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        _blocks=[[NSMutableArray alloc]init];
        if (title&&title.length>0) {
            UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, _view.bounds.size.width, 12)];
            [titleLabel quicklySetFontPoint:12 textColorHex:@"ffffff" textAlignment:NSTextAlignmentCenter text:title];
            [_view addSubview:titleLabel];
            _height=37;
        }else{
            _height=26;
        }
    }
    return self;
}

-(void)addButtonWithTitle:(NSString *)title image:(UIImage *)image block:(SJActionBlock)block{
     __block SJActionBlock myBlock=block;
    [_blocks addObject:[[NSArray alloc]initWithObjects:title,image, myBlock,nil]];
}

-(void)showInView:(UIView *)view{
    NSUInteger i=1;
    NSInteger buttonCount=[self buttonCountWithWidth:_view.bounds.size.width-32];
    if (buttonCount==0) {
        return;
    }
    for (NSArray* _block in _blocks) {
        NSString *title=[_block objectAtIndex:0];
        UIImage *image=[_block objectAtIndex:1];
        CGFloat offset=[self offsetWithWidth:_view.bounds.size.width-32];
        NSInteger x=(i-1)%buttonCount;
        NSInteger y=(i-1)/buttonCount;
        CGRect buttonFrame=CGRectMake(16+x*offset, y*(SJBUTTONWIDTH+44.)+_height, SJBUTTONWIDTH, SJBUTTONWIDTH);
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:image forState:UIControlStateNormal];
        button.frame=buttonFrame;
        button.tag=i;
        [button addTarget:self action:@selector(buttonHighlightAtIndex:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(buttonClickAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(buttonFrame.origin.x-10, buttonFrame.origin.y+buttonFrame.size.height+10, buttonFrame.size.width+20, 12)];
        titleLabel.tag=i+10;
        [titleLabel quicklySetFontPoint:12 textColorHex:@"ffffff" textAlignment:NSTextAlignmentCenter text:title];
        
        [_view addSubview:button];
        [_view addSubview:titleLabel];
        
        i++;
    }
    _height=_height+(SJBUTTONWIDTH+44.)*(([_blocks count]-1)/buttonCount+1);

    UIButton *cancelButton=[[UIButton alloc]initWithFrame:CGRectMake((_view.bounds.size.width-288)/2, _height-4, 288, 30)];
    [cancelButton setBackgroundImage:[[UIImage imageNamed:@"广场模块bg.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    [cancelButton quicklySetFontPoint:14 textColorHex:@"69b1db" textAlignment:NSTextAlignmentCenter title:NSLocalizedString(@"取消", nil)];
    [cancelButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [_view addSubview:cancelButton];
    _height+=50;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    tap.delegate=self;
    [[BlockBackground sharedInstance]addGestureRecognizer:tap];
    
    CGRect viewFrame=_view.frame;
    viewFrame.origin.y=[BlockBackground sharedInstance].bounds.size.height;
    viewFrame.size.height=_height;
    _view.frame=viewFrame;
    [[BlockBackground sharedInstance]addToMainWindow:_view];
    _self=self;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect viewFrame=_view.frame;
        viewFrame.origin.y=[BlockBackground sharedInstance].bounds.size.height-_height;
        _view.frame=viewFrame;
        [BlockBackground sharedInstance].alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)showInViewByTop:(UIView *)view{
    NSUInteger i=1;
    NSInteger buttonCount=[self buttonCountWithWidth:_view.bounds.size.width-60];
    if (buttonCount==0) {
        return;
    }
//    _view.image=[[UIImage imageNamed:@"更多_bg2.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    CGRect frame = _view.frame;
    frame.origin.x +=10;
    frame.size.width -= 20;
    _view.frame = frame;
    
    for (NSArray* _block in _blocks) {
        NSString *title=[_block objectAtIndex:0];
        UIImage *image=[_block objectAtIndex:1];
        CGFloat offset=[self offsetWithWidth:_view.bounds.size.width-40];
        NSInteger x=(i-1)%buttonCount;
        NSInteger y=(i-1)/buttonCount;
        CGRect buttonFrame=CGRectMake(20+x*offset, y*(SJBUTTONWIDTH+32.)-_height + 46, SJBUTTONWIDTH, SJBUTTONWIDTH);
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:image forState:UIControlStateNormal];
        button.frame=buttonFrame;
        button.tag=i;
        [button addTarget:self action:@selector(buttonHighlightAtIndex:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(buttonClickAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y+buttonFrame.size.height+10, buttonFrame.size.width, 12)];
        titleLabel.text=title;
        titleLabel.textColor=[UIColor whiteColor];
        titleLabel.font=[UIFont boldSystemFontOfSize:12];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.tag=i+10;
        titleLabel.backgroundColor=[UIColor clearColor];
        
        
        [_view addSubview:button];
        [_view addSubview:titleLabel];
        
        i++;
    }
    _height=_height+(SJBUTTONWIDTH+32.)*(([_blocks count]-1)/buttonCount+1);


    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    tap.delegate=self;
    [[BlockBackground sharedInstance]addGestureRecognizer:tap];
    
    CGRect viewFrame=_view.frame;
    viewFrame.origin.y=-[BlockBackground sharedInstance].bounds.size.height;
    viewFrame.size.height=_height;
    _view.frame=viewFrame;
    [[BlockBackground sharedInstance]addToMainWindow:_view];
    _self=self;

    [UIView animateWithDuration:0.3 animations:^{
        CGRect viewFrame=_view.frame;
        viewFrame.origin.y = ([BlockBackground sharedInstance].bounds.size.height-_height)/2;
        _view.frame=viewFrame;
        [BlockBackground sharedInstance].alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)buttonHighlightAtIndex:(UIButton*)button{
    UILabel *l=(UILabel*)[_view viewWithTag:button.tag+10];
    [l setTextColor:[UIColor colorWithHex:@"6abfde"]];
}


-(void)buttonClickAtIndex:(UIButton*)button{
    NSUInteger index=button.tag-1;
    SJActionBlock block=[[_blocks objectAtIndex:index]objectAtIndex:2];
    block();
    [self hide];
}

-(void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        [BlockBackground sharedInstance].alpha=0;
        CGRect frame=_view.frame;
        frame.origin.y=[BlockBackground sharedInstance].bounds.size.height;
        _view.frame=frame;
    } completion:^(BOOL finished) {
        for (UIGestureRecognizer *tap in [BlockBackground sharedInstance].gestureRecognizers) {
        if ([tap isKindOfClass:[UITapGestureRecognizer class]]) {
            [[BlockBackground sharedInstance]removeGestureRecognizer:tap];
        }
        }
        [[BlockBackground sharedInstance]removeView:_view];
    }];
    
    _self=nil;
}

-(CGFloat)offsetWithWidth:(CGFloat)width{
    CGFloat buttonWidth=SJBUTTONWIDTH;
    NSInteger i=[self buttonCountWithWidth:width];
    return (width-buttonWidth*i)/(i-1)+buttonWidth;
}

-(NSInteger)buttonCountWithWidth:(CGFloat)width{
    CGFloat buttonWidth=SJBUTTONWIDTH;
    int i=1;
    while (YES) {
        if (i*buttonWidth+(i-1)*16>width) {
            i--;
            break;
        }
        i++;
    }
    return i;
}

-(NSUInteger)buttonCount{
    return [_blocks count];
}

-(void)dealloc{
    _blocks=nil;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIControl class]]) {
        return NO;
    }
    return YES;
}


@end

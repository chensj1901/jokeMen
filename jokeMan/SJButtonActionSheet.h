//
//  SJButtonActionSheet.h
//  zhitu
//
//  Created by 陈少杰 on 14-1-9.
//  Copyright (c) 2014年 聆创科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SJActionBlock)(void);

@interface SJButtonActionSheet : NSObject<UIGestureRecognizerDelegate>
{
    @protected
    
    NSMutableArray *_blocks;
    CGFloat _height;
    UIWindow *_previousWindow;
    SJButtonActionSheet* _self;
}

@property (nonatomic, readonly) UIView *view;
@property (nonatomic, readwrite) BOOL vignetteBackground;

@property(nonatomic,assign)UIView *parentView;

+ (id)sheetWithTitle:(NSString *)title;

- (id)initWithTitle:(NSString *)title;

- (void)addButtonWithTitle:(NSString *) title image:(UIImage*)image block:(SJActionBlock) block;

- (void)showInView:(UIView *)view;
- (void)showInViewByTop:(UIView *)view;

- (NSUInteger)buttonCount;

@end

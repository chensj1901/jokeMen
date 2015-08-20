//
//  SJAlertTextFieldView.h
//  jokeMan
//
//  Created by 陈少杰 on 15/8/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJTextField.h"

typedef void (^SJTipViewSuccessBlock_1)(UIView *thisView);

@interface SJAlertTextFieldView : UIView

@property(nonatomic,readonly)UIImageView *boxImageView;
@property(nonatomic,readonly)UILabel *titleLabel;
@property(nonatomic,readonly)SJTextField *contentTextField;
@property(nonatomic,readonly)UIButton *randomBtn;
@property(nonatomic,readonly)UIButton *okBtn;
@property(nonatomic,readonly)UIButton *cancelBtn;
@property(nonatomic,copy)SJTipViewSuccessBlock_1 finishBlock;

+(void)showInViewWithTitle:(NSString *)title successBlock:(SJTipViewSuccessBlock_1)successBlock;
@end

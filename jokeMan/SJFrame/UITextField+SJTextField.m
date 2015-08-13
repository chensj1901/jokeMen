//
//  UITextField+SJTextField.m
//  zhitu
//
//  Created by 陈少杰 on 14-5-7.
//  Copyright (c) 2014年 聆创科技有限公司. All rights reserved.
//

#import "UITextField+SJTextField.h"

@implementation UITextField (SJTextField)
-(void)quicklySetBoldFontPoint:(CGFloat)point textColorHex:(NSString *)colorHex textAlignment:(NSTextAlignment)textAlignment{
    self.backgroundColor=[UIColor clearColor];
    self.font=[UIFont boldSystemFontOfSize:point];
    self.textColor=[UIColor colorWithHex:colorHex];
    self.textAlignment=textAlignment;
}

-(void)quicklySetFontPoint:(CGFloat)point textColorHex:(NSString *)colorHex textAlignment:(NSTextAlignment)textAlignment{
    self.backgroundColor=[UIColor clearColor];
    self.font=[UIFont systemFontOfSize:point];
    self.textColor=[UIColor colorWithHex:colorHex];
    self.textAlignment=textAlignment;
    
}
@end

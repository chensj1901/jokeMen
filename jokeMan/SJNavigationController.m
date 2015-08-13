//
//  SJNavigationBar.m
//  Yunpan
//
//  Created by 陈少杰 on 15/8/4.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJNavigationController.h"

@implementation SJNavigationController

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *thisVC=[[self viewControllers]lastObject];
    if (thisVC) {
        thisVC.navigationItem.backBarButtonItem=[self navigationWhiteOrGrayBackButton];
    }
    [super pushViewController:viewController animated:animated];
}


-(UIBarButtonItem*)navigationWhiteOrGrayBackButton{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    if (!IS_IOS7()) {
        [backButton setImage:[UIImage imageNamed:@"返回箭头.png"]];
        [backButton setBackButtonBackgroundImage:[[UIImage imageNamed:@"透明.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) ] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
    [backButton setTitleTextAttributes:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(0, 0)],[UIFont systemFontOfSize:14],[UIColor whiteColor],[UIColor whiteColor], nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextShadowOffset,UITextAttributeFont,UITextAttributeTextColor,UITextAttributeTextShadowColor, nil]] forState:UIControlStateNormal];
    [backButton setTitleTextAttributes:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(0, 0)],[UIFont systemFontOfSize:14],[UIColor whiteColor],[UIColor whiteColor], nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextShadowOffset,UITextAttributeFont,UITextAttributeTextColor,UITextAttributeTextShadowColor, nil]] forState:UIControlStateHighlighted];
    backButton.tintColor=[UIColor clearColor];
    return backButton;
}
@end

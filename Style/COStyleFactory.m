//
//  COStyleFactory.m
//  CodingForiPad
//
//  Created by sunguanglei on 15/6/18.
//  Copyright (c) 2015年 coding. All rights reserved.
//

#import "COStyleFactory.h"

@implementation COStyleFactory

+ (void)applyStyle
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bar_topbar"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setTitleTextAttributes:@{
                                                         UITextAttributeTextColor : [UIColor whiteColor],
                                                         UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                                                         UITextAttributeFont : [UIFont systemFontOfSize:18]
                                                         }];
}

@end

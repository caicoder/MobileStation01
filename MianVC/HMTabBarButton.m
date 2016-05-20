//
//  HMTabBarButton.m
//  01-QQ空间
//
//  Created by apple on 15/2/2.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HMTabBarButton.h"

@implementation HMTabBarButton

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_separate_selected_bg"] forState:UIControlStateSelected];
        // 让imageView里面的内容居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 设置内边距
//        self.contentEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
//        self.titleEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
//        // 让所有内容左对齐
//        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
//        self.titleLabel.backgroundColor = [UIColor redColor];
//        self.imageView.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.width == HMDockMinW) { // 竖屏
        // 1.图片
        self.imageView.frame = self.bounds;
        
        // 2.文字
        self.titleLabel.width = -1;
//        self.titleLabel.hidden = YES;
    } else { // 横屏
        // 1.图片
        self.imageView.x = 0;
        self.imageView.y = 0;
        self.imageView.height = self.height;
        self.imageView.width = self.width * 0.4;
        
        // 2.文字
        self.titleLabel.y = 0;
//        self.titleLabel.hidden = NO;
        self.titleLabel.width = self.width - self.imageView.width;
        self.titleLabel.height = self.height;
        self.titleLabel.x = self.imageView.width;
    }
}

@end

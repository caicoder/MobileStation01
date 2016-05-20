//
//  HMTabBar.m
//  01-QQ空间
//
//  Created by apple on 15/2/2.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HMTabBar.h"
#import "HMTabBarButton.h"

@interface HMTabBar()
@property (nonatomic, weak) HMTabBarButton *selectedButton;
@end

@implementation HMTabBar
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupButton:@"tab_bar_feed_icon" title:@"联通基站"];
        [self setupButton:@"tab_bar_passive_feed_icon" title:@"移动基站"];
        [self setupButton:@"tab_bar_pic_wall_icon" title:@"电信基站"];
        [self setupButton:@"tab_bar_e_album_icon" title:@"关于"];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    for (int i = 0; i < count; ++i) {
        HMTabBarButton *button = self.subviews[i];
//        button.tag = i;
        button.width = self.width;
        button.height = HMDockButtonH;
        button.x = 0;
        button.y = i * button.height;
    }
}

#pragma mark - 创建按钮
/**
 *  创建按钮
 *
 *  @param image  按钮的图片
 *  @param title  按钮的标题
 */
- (void)setupButton:(NSString *)image title:(NSString *)title
{
    HMTabBarButton *button = [[HMTabBarButton alloc] init];
    button.tag = self.subviews.count;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:20];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
}

#pragma mark - 监听按钮点击
- (void)buttonClick:(HMTabBarButton *)button
{
    // 更改按钮状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    // 找出被点击按钮的索引
//    [self.subviews indexOfObject:button];
    [HMNoteCenter postNotificationName:HMButtonDidSelectNotification object:nil userInfo:@{HMSelectedButtonIndexKey : @(button.tag)}];
}

@end

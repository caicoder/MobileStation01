//
//  HMDock.m
//  01-QQ空间
//
//  Created by apple on 15/2/2.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HMDock.h"
#import "HMTabBar.h"

@interface HMDock()
@property (nonatomic, weak) HMTabBar *tabBar;
@end

@implementation HMDock

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = HMRGBColor(55, 55, 55);
        
        
        // 2.选项卡
        HMTabBar *tabBar = [[HMTabBar alloc] init];
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    BOOL portarit = self.width == HMDockMinW;
//    
//    // 1.底部工具条
//    self.bottomBar.x = 0;
//    self.bottomBar.width = self.width;
//    if (portarit) { // 竖屏
//        self.bottomBar.height = self.bottomBar.subviews.count * HMDockButtonH;
//    } else { // 横屏
//        self.bottomBar.height = HMDockButtonH;
//    }
//    self.bottomBar.y = self.height - self.bottomBar.height;
    
    // 2.tabBar
    self.tabBar.x = 0;
    self.tabBar.width = self.width;
    self.tabBar.height = 6 * HMDockButtonH;
    self.tabBar.y = self.height-100 - self.tabBar.height;
    

}

@end

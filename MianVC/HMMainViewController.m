//
//  HMMainViewController.m
//  01-QQ空间
//
//  Created by apple on 15/2/2.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HMMainViewController.h"
#import "HMDock.h"
#import "HMTestViewController.h"

@interface HMMainViewController ()
@property (nonatomic, weak) HMDock *dock;
/** 正在显示的子控制器 */
@property (nonatomic, weak) UIViewController *showingChildVc;
@end

@implementation HMMainViewController

#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化子控制器
    [self setupChildVces];
    
    // 初始化dock
    [self setupDock];
    
    // 处理通知
    [self setupNotes];
}

/**
 *  处理通知
 */
- (void)setupNotes
{
    [HMNoteCenter addObserver:self selector:@selector(buttonDidSelect:) name:HMButtonDidSelectNotification object:nil];
}

/**
 *  监听按钮的选中
 */
- (void)buttonDidSelect:(NSNotification *)note
{
    int index = [note.userInfo[HMSelectedButtonIndexKey] intValue];
    [self switchChildVc:index];
}

/**
 *  切换子控制器
 *
 *  @param index 需要显示的子控制器的索引
 */
- (void)switchChildVc:(int)index
{
    UIViewController *willShowChildVc = self.childViewControllers[index];
    if (willShowChildVc == self.showingChildVc) return;
    
    // 1.移除正在显示的子控制器的view
    [self.showingChildVc.view removeFromSuperview];
    
    // 2.添加index位置对应子控制器的view
    willShowChildVc.view.autoresizingMask = UIViewAutoresizingNone;
    willShowChildVc.view.y = 0;
    willShowChildVc.view.x = self.dock.width;
    willShowChildVc.view.height = self.view.height;
    willShowChildVc.view.width = self.view.width - self.dock.width;
    [self.view addSubview:willShowChildVc.view];
    
    // 3.让index位置对应子控制器 成为 当前正在显示的子控制器
    self.showingChildVc = willShowChildVc;
}

- (void)dealloc
{
    [HMNoteCenter removeObserver:self];
}

/**
 *  初始化子控制器
 */
- (void)setupChildVces
{
    HMTestViewController *test01 = [[HMTestViewController alloc] init];
    test01.title = @"联通基站";
    test01.view.frame=CGRectMake(0, 0, kScreen_Width-self.dock.width, kScreen_Height);
    UINavigationController * testNAV01=[[UINavigationController alloc]initWithRootViewController:test01];
    [self addChildViewController:testNAV01];
    
    HMTestViewController *test02 = [[HMTestViewController alloc] init];
    test02.title = @"移动基站";
     UINavigationController * testNAV02=[[UINavigationController alloc]initWithRootViewController:test02];
    [self addChildViewController:testNAV02];
    
    HMTestViewController *test03 = [[HMTestViewController alloc] init];
    test03.title = @"电信基站";
    UINavigationController * testNAV03=[[UINavigationController alloc]initWithRootViewController:test03];
    [self addChildViewController:testNAV03];

    
    HMTestViewController *test06 = [[HMTestViewController alloc] init];
    test06.title = @"关于";
    [self addChildViewController:test06];
}

/**
 *  初始化dock
 */
- (void)setupDock
{
    // 创建dock
    HMDock *dock = [[HMDock alloc] init];
    [self.view addSubview:dock];
    self.dock = dock;
    
    // 根据现在的屏幕尺寸来设置dock的frame
    [self viewWillTransitionToSize:[UIScreen mainScreen].bounds.size withTransitionCoordinator:nil];
}

#pragma mark - 监听屏幕旋转(new)
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSTimeInterval duration = [coordinator transitionDuration];
    [UIView animateWithDuration:duration animations:^{
        self.dock.height = size.height;
        if (size.width > HMScreenMinWH) { // 横屏
            self.dock.width = HMDockMaxW;
        } else { // 竖屏
            self.dock.width = HMDockMinW;
        }
        
        self.showingChildVc.view.y = 0;
        self.showingChildVc.view.x = self.dock.width;
        self.showingChildVc.view.height = size.height;
        self.showingChildVc.view.width = size.width - self.dock.width;
    }];
}

#pragma mark - 监听屏幕旋转(old)
/**
 *  屏幕即将旋转的时候调用
 *
 *  @param toInterfaceOrientation 旋转之后的屏幕方向
 *  @param duration               旋转动画的持续时间
 */
//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    NSLog(@"willRotateToInterfaceOrientation - %d", toInterfaceOrientation);
//}
/**
 *  屏幕旋转完毕的时候调用
 *
 *  @param fromInterfaceOrientation 旋转之前的屏幕方向
 */
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    NSLog(@"didRotateFromInterfaceOrientation - %d", fromInterfaceOrientation);
//}
@end

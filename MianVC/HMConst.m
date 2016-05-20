
#import <UIKit/UIKit.h>

// dock的宽度
const CGFloat HMDockMaxW = 270;
const CGFloat HMDockMinW = 75;

// 屏幕尺寸
const CGFloat HMScreenMaxWH = 1024;
const CGFloat HMScreenMinWH = 768;

// dock内部按钮的高度
const CGFloat HMDockButtonH = 65;

// 通知
// 按钮被选中的通知
NSString *const HMButtonDidSelectNotification = @"HMButtonDidSelectNotification";
// 通过这个key可以取出被选中按钮的索引
NSString *const HMSelectedButtonIndexKey = @"HMSelectedButtonIndexKey";

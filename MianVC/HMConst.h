
#import <UIKit/UIKit.h>

// dock的宽度
UIKIT_EXTERN const CGFloat HMDockMaxW;
UIKIT_EXTERN const CGFloat HMDockMinW;

// 屏幕尺寸
UIKIT_EXTERN const CGFloat HMScreenMaxWH;
UIKIT_EXTERN const CGFloat HMScreenMinWH;

// dock内部按钮的高度
UIKIT_EXTERN const CGFloat HMDockButtonH;

// 通知
// 按钮被选中的通知
UIKIT_EXTERN NSString *const HMButtonDidSelectNotification;
// 通过这个key可以取出被选中按钮的索引
UIKIT_EXTERN NSString *const HMSelectedButtonIndexKey;
//
//  MBProgressHUD+Show.m
//  weibo
//
//  Created by apple on 13-9-1.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+Show.h"


@implementation MBProgressHUD (Show)
+ (void)showText:(NSString *)text name:(NSString *)name
{
    
    CGSize messageSize = [text sizeWithFont:[UIFont systemFontOfSize:25] constrainedToSize:CGSizeMake(kScreen_Width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    
    
    __block UILabel *messageText = [[UILabel alloc] init];
//    messageText.backgroundColor = [UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1];
    messageText.backgroundColor = [UIColor colorWithRed:41/255.0 green:36/255.0 blue:33/255.0 alpha:0.7];
    messageText.textColor = [UIColor whiteColor];
    messageText.textAlignment = NSTextAlignmentCenter;
    messageText.font = [UIFont systemFontOfSize:16];
    messageText.frame = CGRectMake((kScreen_Width - messageSize.width)*0.5, kScreen_Height-90, messageSize.width, 55);
    messageText.text = text;
    
    
//    messageText.layer.cornerRadius = 5;
//    messageText.layer.masksToBounds = YES;
    
    
    UIWindow *currentWindow = [[[UIApplication sharedApplication] windows] lastObject];
    [currentWindow addSubview:messageText];
    
    

    
    [UIView animateWithDuration:0.3 animations:^{
        
//        messageText.transform = CGAffineTransformMakeTranslation((kScreenSize.width - messageSize.width)*0.5, kScreenSize.height - 100);
        messageText.frame = CGRectMake((kScreen_Width - messageSize.width)*0.5, kScreen_Height - 100, messageSize.width , 35);
        
    } completion:^(BOOL finished) {
        
        float delayToStartRecording = 1;
        dispatch_time_t startTime = dispatch_time(DISPATCH_TIME_NOW, delayToStartRecording * NSEC_PER_SEC);
        dispatch_after(startTime, dispatch_get_main_queue(), ^(void){
            
            [messageText removeFromSuperview];
            messageText = nil;
            
        });

        
    }];
    

   
////    NSLog(@" windows = %@",[[[UIApplication sharedApplication] windows] lastObject]);
//    
//    //显示在马格view这个很重要否则屏幕会锁死
//    UIWindow *currentWindow = [[[UIApplication sharedApplication] windows] lastObject];
////    UIView *targetView = [currentWindow.subviews firstObject];
//    
//    
//    // 显示加载失败
//    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:currentWindow animated:YES];
//    
//    // 显示一张图片(mode必须写在customView设置之前)
//    hud.mode = MBProgressHUDModeCustomView;
//    // 设置一张图片
//    name = [NSString stringWithFormat:@"MBProgressHUD.bundle/%@", name];
//    
//    
//    
//    // 显示自定义view
//    CGSize showTitleSize = [text sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(kScreenSize.width*0.6, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
//    
//    
//    MyAlertViewCustom *mycustom = [[MyAlertViewCustom alloc] init];
//    
//    mycustom.bounds = CGRectMake(0, 0, showTitleSize.width, showTitleSize.height + kImageWidth);
//    
//    [mycustom setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
//    
//    [mycustom setTitle:text forState:UIControlStateNormal];
//    
//
//    
//    
//    hud.customView = mycustom;
////    hud.labelText = text;
//    
//    
//    // 隐藏的时候从父控件中移除
//    hud.removeFromSuperViewOnHide = YES;
//    
//    // 1秒后自动隐藏
//    [hud hide:YES afterDelay:1];
    
    
}

+ (void)showErrorWithText:(NSString *)text
{
    [self showText:text name:@"error.png"];
}

+ (void)showSuccessWithText:(NSString *)text
{
    [self showText:text name:@"success.png"];
}
+ (void)showWithText:(NSString *)text{
    
    
    // 显示加载失败
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] windows] lastObject] animated:YES];
    
    // 显示一张图片(mode必须写在customView设置之前)
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.labelText = text;
    
    // 隐藏的时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒后自动隐藏
    [hud hide:YES afterDelay:1];
    
}
@end

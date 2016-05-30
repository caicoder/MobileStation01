//
//  CORootViewController.h
//  MobileStation
//
//  Created by DS365 on 16/5/28.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COMesageController.h"
#import "COContainerSegue.h"

@interface CORootViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;
@property (weak, nonatomic) IBOutlet UIView *DoduckBg;
@property (weak, nonatomic) IBOutlet UIView *container;

@property (nonatomic,strong)UIViewController * selectedController;

@property (nonatomic,strong)COMesageController  * msgController;
+ (instancetype)currentRoot;

- (void)popoverController:(UIViewController *)controller withSize:(CGSize)size;
- (void)dismissPopover;
- (void)popoverChangeSize:(CGSize)size;
- (void)popoverChangeRect:(CGRect)rect withDuration:(NSTimeInterval)duration withCurve:(UIViewAnimationCurve)curve;

@end

//
//  COMesageController.m
//  CodingForiPad
//
//  Created by sunguanglei on 15/6/14.
//  Copyright (c) 2015年 coding. All rights reserved.
//

#import "COMesageController.h"
#import "SearchVC.h"
#import "CORegServiceViewController.h"
#import "DataManmager.h"


static COMesageController *rootController = nil;

@interface COMesageController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UINavigationController *leftNav;
@property (nonatomic,strong)UIViewController * leftViewVC;
@property (nonatomic,strong)UIViewController *  rightVC;
@property (nonatomic, assign) BOOL showDetail;


@end

@implementation COMesageController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.leftViewVC.view.frame=self.leftView.bounds;
//    [self.leftView addSubview:self.leftViewVC.view];
//    self.rightVC.view.frame=self.rightView.frame;
//    [self.rightView addSubview:self.rightVC.view];
  

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"leftNavVC"]) {
        self.leftNav = segue.destinationViewController;
        self.leftNav.delegate = self;
        self.leftViewVC = self.leftNav.viewControllers.firstObject;
    }
    else if ([segue.identifier isEqualToString:@"RightVC"]) {
        self.rightVC = segue.destinationViewController;
    }
}
@end

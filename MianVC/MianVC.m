//
//  MianVC.m
//  MobileStation
//
//  Created by DS365 on 16/5/18.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import "MianVC.h"
#import "SearchVC.h"
#import "CORegServiceViewController.h"

@interface MianVC ()

@end

@implementation MianVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildVC];
    // Do any additional setup after loading the view.
}

-(void)setUpChildVC
{
 
  
  
    SearchVC * vc=[[SearchVC alloc]init];
    vc.view.frame=CGRectMake(0, 0, self.view.width*0.25, self.view.height);
//    UINavigationController * testNAV03=[[UINavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
//    [self addChildViewController:vc];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  COAboutViewcontroller.m
//  MobileStation
//
//  Created by DS365 on 16/5/29.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import "COAboutViewcontroller.h"

@interface COAboutViewcontroller ()

@end

@implementation COAboutViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"关于";
    [self.view setBackgroundColor:kGlobalBg];
    UIButton * back =[[UIButton alloc]init];
    back.bounds=CGRectMake(0, 0, 200, 49);
    [back setTitle:@"退出登录" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [back setBackgroundColor:[UIColor greenColor]];
    [back setBackgroundImage:[UIImage imageNamed:@"bar_topbar"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    back.titleLabel.font=[UIFont systemFontOfSize:20];
    back.center=self.view.center;
    back.layer.cornerRadius=back.height*0.5;
    back.layer.masksToBounds=YES;
    
    [self.view addSubview:back];
   
    // Do any additional setup after loading the view.
}
-(void)backClick:(UIButton *)btn
{
    [HMNoteCenter postNotificationName:__USER_LOGINOUT_SUCCESS object:nil];
    NSUserDefaults * stand=[NSUserDefaults standardUserDefaults];
    [stand removeObjectForKey:USERKEY];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

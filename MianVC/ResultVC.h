//
//  ResultVC.h
//  MobileStation
//
//  Created by DS365 on 16/5/20.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultVC : UIViewController
@property (nonatomic,strong)NSMutableArray * resultList;
@property (weak, nonatomic) IBOutlet UITableView *tav;
@property (weak, nonatomic) IBOutlet UIButton *showBtn;
- (IBAction)showBtnClick:(UIButton *)sender;
@property (nonatomic,assign)int type;
@end

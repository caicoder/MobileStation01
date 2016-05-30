//
//  SearchVC.h
//  MobileStation
//
//  Created by DS365 on 16/5/18.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *taV;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
- (IBAction)searchBtnClick:(UIButton *)sender;

@end

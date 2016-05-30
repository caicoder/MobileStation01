//
//  ShowTwoVC.h
//  MobileStation
//
//  Created by DS365 on 16/5/29.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dataModel.h"

@interface ShowTwoVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *lacInputView;
@property (weak, nonatomic) IBOutlet UITextField *cellInputView;
@property (weak, nonatomic) IBOutlet UIButton *tenBtn;
@property (weak, nonatomic) IBOutlet UIButton *sixteenBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic,assign)int type;

- (IBAction)tenBtnClick:(UIButton *)sender;
- (IBAction)sixtenBtnClick:(UIButton *)sender;
- (IBAction)deleteBtnClick:(UIButton *)sender;

@property (nonatomic,copy) void (^clickSureBtn)(dataModel * keyWordItem);
- (dataModel *)AddDataModel;
@end

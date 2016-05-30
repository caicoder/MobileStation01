//
//  ShowTwoVC.m
//  MobileStation
//
//  Created by DS365 on 16/5/29.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import "ShowTwoVC.h"
#import "DataManmager.h"
#import "CORootViewController.h"
@interface ShowTwoVC ()

@end

@implementation ShowTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self setupUI];
}
-(void)setupUI
{
    self.tenBtn.selected=YES;
    self.lacInputView.keyboardType=UIKeyboardTypeNumberPad;
    self.cellInputView.keyboardType=UIKeyboardTypeNumberPad;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)tenBtnClick:(UIButton *)sender {
    if (sender.selected)return;
    self.sixteenBtn.selected=NO;
    sender.selected=YES;
}

- (IBAction)sixtenBtnClick:(UIButton *)sender {
    if (!sender.selected)return;
    sender.selected=YES;
    self.tenBtn.selected=NO;
    
}

- (IBAction)deleteBtnClick:(UIButton *)sender {
    if (self.lacInputView.text.length<=0||self.cellInputView.text.length<=0) {
        [MBProgressHUD showWithText:@"请填完查询条件"];
        return;
    }
//    NSMutableDictionary * mutableDic =[[NSMutableDictionary alloc]init];
//    [mutableDic setObject:self.cellInputView.text forKey:@"cell"];
//    [mutableDic setObject:self.lacInputView.text forKey:@"lac"];
    
    if (_clickSureBtn) {
        _clickSureBtn([self AddDataModel]);
    }
    
//    switch (self.type) {
//        case 1:
//        {
//            [[DataManmager sharedDataManmager] addToYiDongCar:[self AddDataModel] success:^{
//                NSDictionary *userInfo = @{@"commodityModel" : [self AddDataModel]};
//                [HMNoteCenter postNotificationName:SEARCHVCRELOAD object:nil userInfo:userInfo];
//            }];
//        }
//            break;
//            
//        case 2:
//        {
//            [[DataManmager sharedDataManmager] addToLiantongCar:[self AddDataModel] success:^{
//                NSDictionary *userInfo = @{@"commodityModel" : [self AddDataModel]};
//                [HMNoteCenter postNotificationName:SEARCHVCRELOAD object:nil userInfo:userInfo];
//            }];
//        }
//            break;       
//        default:
//            break;
//    }
    
    [[CORootViewController currentRoot] dismissPopover];
}
- (dataModel *)AddDataModel
{
    dataModel * model=[[dataModel alloc]init];
    model.dataKey=[NSString stringWithFormat:@"lac%@cell%@nib%@",self.lacInputView.text,self.cellInputView.text,@"0"];
    model.cell=self.cellInputView.text;
    model.lac=self.lacInputView.text;
    model.nid=@"0";
    return model;
}

@end

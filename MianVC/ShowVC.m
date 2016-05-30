//
//  ShowVC.m
//  MobileStation
//
//  Created by DS365 on 16/5/26.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import "ShowVC.h"
#import "DataManmager.h"
#import "CORootViewController.h"

@interface ShowVC ()

@end

@implementation ShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self setupUI];
}
-(void)setupUI
{
    self.tenBtn.selected=YES;
    self.lacInputView.keyboardType=UIKeyboardTypeNumberPad;
    self.nibInputView.keyboardType=UIKeyboardTypeNumberPad;
    self.cellInputView.keyboardType=UIKeyboardTypeNumberPad;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setType:(int)type
{
    _type=type;
    switch (type) {
        case 1:
        {
            self.nibInputView.hidden=YES;
            self.nibNamelabel.hidden=YES;
        }
            break;
        case 2:
        {
            self.nibInputView.hidden=YES;
            self.nibNamelabel.hidden=YES;
        }
            break;
        case 3:
        {
            self.nibInputView.hidden=NO;
            self.nibNamelabel.hidden=NO;
        }
            break;
            
        default:
            break;
    }
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
        [MBProgressHUD showWithText:@"请填完信息"];
        return;
    }
    NSMutableDictionary * mutableDic =[[NSMutableDictionary alloc]init];
    [mutableDic setObject:self.cellInputView.text forKey:@"cell"];
    [mutableDic setObject:self.lacInputView.text forKey:@"lac"];
//    if (self.nibInputView.text==nil) {
//        [mutableDic setObject:@"0" forKey:@"nib"];
//    }else
//    {
//        [mutableDic setObject:self.nibInputView.text forKey:@"nib"];
//    }
  
    if (_clickSureBtn) {
        _clickSureBtn([self AddDataModel]);
    }
    
//    switch (self.type) {
//        case 1:
//        {
//            self.nibInputView.text=@"0";
//            [[DataManmager sharedDataManmager] addToYiDongCar:[self AddDataModel] success:^{
//                NSDictionary *userInfo = @{@"commodityModel" : [self AddDataModel]};
//                [HMNoteCenter postNotificationName:SEARCHVCRELOAD object:nil userInfo:userInfo];
//            }];
//        }
//            break;
//            
//        case 2:
//        {
//            self.nibInputView.text=@"0";
//            [[DataManmager sharedDataManmager] addToLiantongCar:[self AddDataModel] success:^{
//                NSDictionary *userInfo = @{@"commodityModel" : [self AddDataModel]};
//                [HMNoteCenter postNotificationName:SEARCHVCRELOAD object:nil userInfo:userInfo];
//            }];
//        }
//            break;
//        case 3:
//        {
//            if (self.nibInputView.text==nil) {
//                [MBProgressHUD showWithText:@"请填完信息"];
//                return;
//            }
//            [[DataManmager sharedDataManmager] addToDianxinCar:[self AddDataModel] success:^{
//                NSDictionary *userInfo = @{@"commodityModel" : [self AddDataModel]};
//                [HMNoteCenter postNotificationName:SEARCHVCRELOAD object:nil userInfo:userInfo];
//            }];
//        }
//            break;
//            
//            
//        default:
//            break;
//    }
    
      [[CORootViewController currentRoot] dismissPopover];
}
- (dataModel *)AddDataModel
{
    dataModel * model=[[dataModel alloc]init];
    model.dataKey=[NSString stringWithFormat:@"lac%@cell%@nib%@",self.lacInputView.text,self.cellInputView.text,self.nibInputView.text];
    model.cell=self.cellInputView.text;
    model.lac=self.lacInputView.text;
    model.nid=self.nibInputView.text;
    
    return model;
}


@end

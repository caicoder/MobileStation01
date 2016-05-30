//
//  InputCell.m
//  MobileStation
//
//  Created by DS365 on 16/5/24.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import "InputCell.h"
#import "DataManmager.h"
#import "dataModel.h"

@implementation InputCell

- (void)awakeFromNib {
  
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    if (self.lacInputView.text==nil||self.cellInputView.text==nil) {
        [MBProgressHUD showWithText:@"请填完信息"];
        return;
    }
    switch (self.type) {
        case 1:
        {
            self.nibInputView.text=@"0";
            [[DataManmager sharedDataManmager] addToYiDongCar:[self AddDataModel] success:^{
                 NSDictionary *userInfo = @{@"commodityModel" : [self AddDataModel]};
                [HMNoteCenter postNotificationName:SEARCHVCRELOAD object:nil userInfo:userInfo];
            }];
        }
            break;
            
        case 2:
        {
            self.nibInputView.text=@"0";
            [[DataManmager sharedDataManmager] addToLiantongCar:[self AddDataModel] success:^{
                NSDictionary *userInfo = @{@"commodityModel" : [self AddDataModel]};
                [HMNoteCenter postNotificationName:SEARCHVCRELOAD object:nil userInfo:userInfo];
            }];
        }
            break;
        case 3:
        {
            if (self.nibInputView.text==nil) {
                [MBProgressHUD showWithText:@"请填完信息"];
                return;
            }
            [[DataManmager sharedDataManmager] addToDianxinCar:[self AddDataModel] success:^{
                NSDictionary *userInfo = @{@"commodityModel" : [self AddDataModel]};
                [HMNoteCenter postNotificationName:SEARCHVCRELOAD object:nil userInfo:userInfo];
            }];
        }
            break;
            
            
        default:
            break;
    }
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

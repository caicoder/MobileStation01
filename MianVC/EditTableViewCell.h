//
//  EditTableViewCell.h
//  MobileStation
//
//  Created by DS365 on 16/5/16.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dataModel.h"

@interface EditTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *tenBtn;
@property (weak, nonatomic) IBOutlet UIButton *sixtenbtn;
@property (weak, nonatomic) IBOutlet UIButton *deletebtn;
@property (weak, nonatomic) IBOutlet UILabel *LACinputView;
@property (weak, nonatomic) IBOutlet UILabel *CELLinputView;
@property (weak, nonatomic) IBOutlet UILabel *NIDinputView;
@property (weak, nonatomic) IBOutlet UILabel *nibNameLabel;

- (IBAction)tenBtnClick:(UIButton *)sender;
- (IBAction)sixtenBtnClick:(UIButton *)sender;
- (IBAction)deleteBtnClick:(UIButton *)sender;


@property (nonatomic,assign) int   type;
@property (nonatomic,strong)dataModel * model;
@end

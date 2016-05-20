//
//  EditTableViewCell.h
//  MobileStation
//
//  Created by DS365 on 16/5/16.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *LACinputView;
@property (weak, nonatomic) IBOutlet UITextField *CELLinputView;
@property (weak, nonatomic) IBOutlet UIButton *tenBtn;
@property (weak, nonatomic) IBOutlet UIButton *sixtenbtn;
@property (weak, nonatomic) IBOutlet UIButton *deletebtn;

- (IBAction)tenBtnClick:(UIButton *)sender;
- (IBAction)sixtenBtnClick:(UIButton *)sender;
- (IBAction)deleteBtnClick:(UIButton *)sender;
@end

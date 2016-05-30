//
//  EditTableViewCell.m
//  MobileStation
//
//  Created by DS365 on 16/5/16.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import "EditTableViewCell.h"
#import "NSString+Hex.h"
@interface EditTableViewCell ()


@end

@implementation EditTableViewCell
- (IBAction)tenBtnClick:(UIButton *)sender {
    self.CELLinputView.text=[NSString stringFromHexString:self.CELLinputView.text];
    self.LACinputView.text=[NSString stringFromHexString:self.LACinputView.text];
}
- (IBAction)sixtenBtnClick:(UIButton *)sender {
    self.CELLinputView.text=[NSString hexStringFromString:self.CELLinputView.text];
    self.LACinputView.text=[NSString hexStringFromString:self.LACinputView.text];
}
- (IBAction)deleteBtnClick:(UIButton *)sender {
    
}

-(void)setType:(int)type
{
    _type=type;
    switch (type) {
        case 0:
        {
            self.nibNameLabel.hidden=YES;
            self.NIDinputView.hidden=YES;
        }
            break;
        case 1:
        {
            self.nibNameLabel.hidden=YES;
            self.NIDinputView.hidden=YES;
        }
            break;
        case 3:
        {
            self.nibNameLabel.hidden=NO;
            self.NIDinputView.hidden=NO;
        }
            break;
            
        default:
            break;
    }
}

- (void)awakeFromNib {
    self.nibNameLabel.layer.borderWidth=0.5;
    self.nibNameLabel.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.CELLinputView.layer.borderWidth=0.5;
    self.CELLinputView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.LACinputView.layer.borderWidth=0.5;
    self.LACinputView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.CELLinputView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewGestureRecognizer:)]];
    [self.LACinputView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewGestureRecognizer:)]];
    [self.CELLinputView setUserInteractionEnabled:YES];
    [self.LACinputView setUserInteractionEnabled:YES];
}
-(void)viewGestureRecognizer:(UITapGestureRecognizer *)tap
{
    [HMNoteCenter postNotificationName:SHOWINPUTVIEW object:nil];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(dataModel *)model
{
    _model=model;
    self.CELLinputView.text=model.cell;
    self.LACinputView.text=model.lac;
    self.NIDinputView.text=model.nid;
}

@end

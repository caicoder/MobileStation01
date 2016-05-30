//
//  resultCell.m
//  MobileStation
//
//  Created by DS365 on 16/5/20.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import "resultCell.h"
@interface resultCell ()
@property (weak, nonatomic) IBOutlet UILabel *mncLabel;
@property (weak, nonatomic) IBOutlet UILabel *lacLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *BLAT;
@property (weak, nonatomic) IBOutlet UILabel *BLNG;
@property (weak, nonatomic) IBOutlet UILabel *jingduLabel;
@property (weak, nonatomic) IBOutlet UILabel *weiduLabel;
@property (weak, nonatomic) IBOutlet UILabel *scopeLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;

@end
@implementation resultCell

- (void)awakeFromNib {
    // Initialization code
    
}

-(void)setResultModel:(resultModel *)resultModel
{
    _resultModel=resultModel;
    self.mncLabel.text=[NSString stringWithFormat:@"MNC:%@",resultModel.MNC];
    self.lacLabel.text=[NSString stringWithFormat:@"LAC:%@",resultModel.LAC];
    self.cellLabel.text=[NSString stringWithFormat:@"CELL:%@",resultModel.CELL];
    self.locationLabel.text=resultModel.ADDRESS;
    self.jingduLabel.text=resultModel.LAT;
    self.weiduLabel.text=resultModel.LNG;
    self.scopeLabel.text=resultModel.PRECISION;
    self.msgLabel.text=resultModel.MSG;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

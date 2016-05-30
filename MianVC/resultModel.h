//
//  resultModel.h
//  MobileStation
//
//  Created by DS365 on 16/5/25.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resultModel : NSObject
@property (nonatomic,copy)NSString * MCC;
@property (nonatomic,copy)NSString * MNC;
@property (nonatomic,copy)NSString * LAC;
@property (nonatomic,copy)NSString * CELL;
@property (nonatomic,copy)NSString * LNG;
@property (nonatomic,copy)NSString * LAT;
@property (nonatomic,copy)NSString * PRECISION;
@property (nonatomic,copy)NSString * ADDRESS;
@property (nonatomic,copy)NSString * MSG;
@end

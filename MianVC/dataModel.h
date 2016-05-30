//
//  dataModel.h
//  MobileStation
//
//  Created by DS365 on 16/5/24.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface dataModel : NSObject<NSCoding,NSCoding>
@property (nonatomic,copy) NSString *dataKey;
@property (nonatomic,copy) NSString *cell;
@property (nonatomic,copy) NSString *nid;
@property (nonatomic,copy) NSString *lac;

@end

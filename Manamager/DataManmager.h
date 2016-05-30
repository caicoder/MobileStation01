//
//  DataManmager.h
//  MobileStation
//
//  Created by DS365 on 16/5/24.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dataModel.h"

typedef void(^AddCarSuccess)();

@interface DataManmager : NSObject

singleton_interface(DataManmager)

@property (nonatomic,strong) NSMutableArray *dianxinList;
@property (nonatomic,strong) NSMutableArray *liantongList;
@property (nonatomic,strong) NSMutableArray *yidongList;

//添加到数据库
- (void)addToDianxinCar:(dataModel *)shopcar success:(AddCarSuccess)success;

- (void)addToLiantongCar:(dataModel *)shopcar success:(AddCarSuccess)success;

- (void)addToYiDongCar:(dataModel *)shopcar success:(AddCarSuccess)success;


//删除数据库
- (BOOL)deleteDianXin:(dataModel *)model;

- (BOOL)deleteLiantong:(dataModel *)model;

- (BOOL)deleteYidong:(dataModel *)model;
@end

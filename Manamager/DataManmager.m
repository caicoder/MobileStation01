//
//  DataManmager.m
//  MobileStation
//
//  Created by DS365 on 16/5/24.
//  Copyright © 2016年 MobileStation. All rights reserved.
//
#define dianxinName @"dianxin.data"
#define dianxinPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:dianxinName]
#define dianxinKey @"dianxin"

#define liantongName @"liantong.data"
#define liantongPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:liantongName]
#define liantongKey @"liantong"

#define yidongName @"yidong.data"
#define yidongPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:yidongName]
#define yidongKey @"yidong"

#import "DataManmager.h"


@implementation DataManmager

singleton_implementation(DataManmager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        @try {
            //1.0 获取对象
            NSData *dianxidata = [NSData dataWithContentsOfFile:dianxinPath];
            NSKeyedUnarchiver * dianxiunarchier = [[NSKeyedUnarchiver alloc] initForReadingWithData:dianxidata];
            _dianxinList =  (NSMutableArray *)[dianxiunarchier decodeObjectForKey:dianxinKey];
            [dianxiunarchier finishDecoding];
            
            NSData *liantongdata = [NSData dataWithContentsOfFile:liantongPath];
            NSKeyedUnarchiver * liantongunarchier = [[NSKeyedUnarchiver alloc] initForReadingWithData:liantongdata];
            _dianxinList = (NSMutableArray *)[liantongunarchier decodeObjectForKey:liantongKey];
            [liantongunarchier finishDecoding];
            
            NSData * yidongdata=[NSData dataWithContentsOfFile:yidongPath];
            NSKeyedUnarchiver * yidongunarchier =[[NSKeyedUnarchiver alloc]initForReadingWithData:yidongdata];
            _yidongList= (NSMutableArray *)[yidongunarchier decodeObjectForKey:yidongKey];
            [yidongunarchier finishDecoding];
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
            if (_dianxinList == nil) {
                _dianxinList = [NSMutableArray array];
            }
            if (_liantongList==nil) {
                _liantongList=[NSMutableArray array];
            }
            if (_yidongList==nil) {
                _yidongList=[NSMutableArray array];
            }
        }
        
    }
    return self;
}


- (void)updateDianXinBoxData{
    //2. 更新沙盒
    NSMutableData *mutableData = [[NSMutableData alloc] init];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
    
    [archiver encodeObject:_dianxinList forKey:dianxinName];
    
    [archiver finishEncoding];
    
    [mutableData writeToFile:dianxinPath  atomically:YES];
    
}

- (void)updateYiDongBoxData{
    //2. 更新沙盒
    NSMutableData *mutableData = [[NSMutableData alloc] init];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
    
    [archiver encodeObject:_yidongList forKey:yidongName];
    
    [archiver finishEncoding];
    
    [mutableData writeToFile:yidongPath  atomically:YES];
}

- (void)updateLiantongBoxData{
    //2. 更新沙盒
    NSMutableData *mutableData = [[NSMutableData alloc] init];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
    
    [archiver encodeObject:_liantongList forKey:liantongName];
    
    [archiver finishEncoding];
    
   [mutableData writeToFile:liantongPath  atomically:YES];
    
}


- (void)addToDianxinCar:(dataModel *)shopcar success:(AddCarSuccess)success
{
    for (dataModel * model in _dianxinList) {
        if ([model.dataKey isEqualToString:shopcar.dataKey]) {
            [MBProgressHUD showWithText:@"该记录已存在"];
            return;
        }
    }
    [_dianxinList insertObject:shopcar atIndex:0];
    [self updateDianXinBoxData];
    
    if (success) {
        success();
    }

}

- (void)addToLiantongCar:(dataModel *)shopcar success:(AddCarSuccess)success
{
    for (dataModel * model in _liantongList) {
        if ([model.dataKey isEqualToString:shopcar.dataKey]) {
            [MBProgressHUD showWithText:@"该记录已存在"];
            return;
        }
    }
    [_liantongList insertObject:shopcar atIndex:0];
    [self updateLiantongBoxData];
    
    if (success) {
        success();
    }

}

- (void)addToYiDongCar:(dataModel *)shopcar success:(AddCarSuccess)success
{
    for (dataModel * model in _yidongList) {
        if ([model.dataKey isEqualToString:shopcar.dataKey]) {
            [MBProgressHUD showWithText:@"该记录已存在"];
            return;
        }
    }
    [_yidongList insertObject:shopcar atIndex:0];
    [self updateYiDongBoxData];
    
    if (success) {
        success();
    }

}

#pragma mark 通过id删除
- (BOOL)deleteYidong:(dataModel *)model{
    
    //遍历购物车，找到商品就删除
    for (dataModel * data in _yidongList) {
        if ([model.dataKey isEqualToString:data.dataKey]) {
            [_yidongList removeObject:data];
            [self updateYiDongBoxData];
            return YES;
        }
    }
    return NO;
}

- (BOOL)deleteLiantong:(dataModel *)model{
    
    //遍历购物车，找到商品就删除
    for (dataModel * data in _liantongList) {
        if ([model.dataKey isEqualToString:data.dataKey]) {
            [_liantongList removeObject:data];
            [self updateLiantongBoxData];
            return YES;
        }
    }
    return NO;
}

- (BOOL)deleteDianXin:(dataModel *)model{
    
    //遍历购物车，找到商品就删除
    for (dataModel * data in _dianxinList) {
        if ([model.dataKey isEqualToString:data.dataKey]) {
            [_dianxinList removeObject:data];
            [self updateDianXinBoxData];
            return YES;
        }
    }
    return NO;
}

@end

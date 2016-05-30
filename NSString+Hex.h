//
//  NSString+Hex.h
//  MobileStation
//
//  Created by DS365 on 16/5/23.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hex)
// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString;
// 普通字符转换层16进制
+ (NSString *)hexStringFromString:(NSString *)string;

@end

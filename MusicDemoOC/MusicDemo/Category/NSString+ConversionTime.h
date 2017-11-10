//
//  NSString+ConversionTime.h
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/8.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ConversionTime)
//时间转字符串
+ (NSString *)stringWithTime:(NSTimeInterval)time;
@end

//
//  LrcLine.h
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/9.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LrcLine : NSObject
//时间
@property (assign, nonatomic) NSTimeInterval time;
//歌词
@property (copy, nonatomic) NSString *lrc;

+ (instancetype)lrcLineWithLrcString:(NSString *)lrcString;
@end

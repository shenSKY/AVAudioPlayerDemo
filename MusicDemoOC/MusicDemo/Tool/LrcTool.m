//
//  LrcTool.m
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/9.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import "LrcTool.h"
#import "LrcLine.h"
@implementation LrcTool
+ (NSArray *)getLrcsWithLrcName:(NSString *)lrcName
{
//    获取歌词路径
    NSString *lrcFilePath = [[NSBundle mainBundle]pathForResource:lrcName ofType:nil];
//    加载对应歌词
    NSString *lrcString = [NSString stringWithContentsOfFile:lrcFilePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *lrcs = [lrcString componentsSeparatedByString:@"\n"];
//    遍历歌词
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSString *lrcLineString in lrcs) {
//        过滤不需要的信息(行号)
        if ([lrcLineString hasPrefix:@"[ti:"] || [lrcLineString hasPrefix:@"[ar:"] || [lrcLineString hasPrefix:@"[al:"] || ![lrcLineString hasPrefix:@"["]) {
            continue;
        }
//        每句歌词转模型
        LrcLine *lrcLine = [LrcLine lrcLineWithLrcString:lrcLineString];
        [tempArray addObject:lrcLine];
    }
    return tempArray;
}
@end

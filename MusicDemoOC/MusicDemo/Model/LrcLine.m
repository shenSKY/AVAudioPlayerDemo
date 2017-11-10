//
//  LrcLine.m
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/9.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import "LrcLine.h"

@implementation LrcLine
- (instancetype)initWithLrcString:(NSString *)lrcString
{
    if (self == [super init]) {
        self.lrc = [[lrcString componentsSeparatedByString:@"]"]lastObject];
        NSString *timeString = [[[lrcString componentsSeparatedByString:@"]"]firstObject]substringFromIndex:1];
        self.time = [self timeWithString:timeString];
    }
    return self;
}
- (NSTimeInterval)timeWithString:(NSString *)timeString
{
    NSInteger min = [[[timeString componentsSeparatedByString:@":"]firstObject] integerValue];
    NSInteger second = [[[[[timeString componentsSeparatedByString:@":"]lastObject]componentsSeparatedByString:@"."]firstObject]integerValue];
    NSInteger millisecond = [[[[[timeString componentsSeparatedByString:@":"]lastObject]componentsSeparatedByString:@"."]lastObject]integerValue];
    return min * 60 + second + millisecond * 0.01;
}
+ (instancetype)lrcLineWithLrcString:(NSString *)lrcString
{
    return [[[self class] alloc]initWithLrcString:lrcString];
}
@end

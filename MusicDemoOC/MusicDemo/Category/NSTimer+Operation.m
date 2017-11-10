//
//  NSTimer+Operation.m
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/8.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import "NSTimer+Operation.h"

@implementation NSTimer (Operation)
- (void)pauseTimer
{
    self.fireDate = [NSDate distantFuture];
}
- (void)resumeTimer
{
    self.fireDate = [NSDate date];
}
@end

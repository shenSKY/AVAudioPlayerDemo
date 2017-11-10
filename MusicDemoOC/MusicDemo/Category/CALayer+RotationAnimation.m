//
//  CALayer+RotationAnimation.m
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/8.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import "CALayer+RotationAnimation.h"

@implementation CALayer (RotationAnimation)

- (void)startAnimate
{
    CABasicAnimation *rotationAnimate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimate.fromValue = @(0);
    rotationAnimate.toValue = @(M_PI * 2);
    rotationAnimate.repeatCount = MAXFLOAT;
    rotationAnimate.duration = 30;
    rotationAnimate.removedOnCompletion = NO;
    
    [self addAnimation:rotationAnimate forKey:nil];
}
- (void)pauseAnimate
{
    CFTimeInterval pauseTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pauseTime;
}
- (void)resumeAnimate
{
    CFTimeInterval pauseTime = self.timeOffset;
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    self.beginTime = timeSincePause;
}
@end

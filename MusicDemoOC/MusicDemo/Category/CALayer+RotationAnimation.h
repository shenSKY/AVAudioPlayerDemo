//
//  CALayer+RotationAnimation.h
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/8.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (RotationAnimation)
//开始动画
- (void)startAnimate;
//暂停动画
- (void)pauseAnimate;
//恢复动画
- (void)resumeAnimate;

@end

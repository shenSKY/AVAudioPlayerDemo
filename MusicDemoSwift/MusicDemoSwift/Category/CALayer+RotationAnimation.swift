//
//  CALayer+RotationAnimation.swift
//  MusicDemoSwift
//
//  Created by 沈凯 on 2017/11/20.
//  Copyright © 2017年 Ssky. All rights reserved.
//

import Foundation
import QuartzCore

extension CALayer {
//    开始动画
    func startAnimate() {
        let rotationAnimate = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimate.fromValue = 0
        rotationAnimate.toValue = .pi * 2.0
        rotationAnimate.repeatCount = MAXFLOAT
        rotationAnimate.duration = 30
        rotationAnimate.isRemovedOnCompletion = false
        add(rotationAnimate, forKey: nil)
    }
//    暂停动画
    func pauseAnimate() {
        let pauseTime: CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0
        timeOffset = pauseTime
    }
//    恢复动画
    func resumeAnimate() {
        let pauseTime = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let timeSincePause: CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil) - pauseTime
        beginTime = timeSincePause
    }
}

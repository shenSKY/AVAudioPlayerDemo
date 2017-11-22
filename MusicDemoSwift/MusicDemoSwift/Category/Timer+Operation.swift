//
//  NSTimer+Operation.swift
//  MusicDemoSwift
//
//  Created by 沈凯 on 2017/11/20.
//  Copyright © 2017年 Ssky. All rights reserved.
//

import Foundation

extension Timer {
//    暂停定时器
    func pauseTimer() {
        fireDate = Date.distantFuture
    }
//    恢复定时器
    func resumeTimer() {
        fireDate = Date()
    }
}

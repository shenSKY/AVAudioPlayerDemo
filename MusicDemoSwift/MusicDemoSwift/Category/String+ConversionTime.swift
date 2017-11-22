//
//  NSString+ConversionTime.swift
//  MusicDemoSwift
//
//  Created by 沈凯 on 2017/11/20.
//  Copyright © 2017年 Ssky. All rights reserved.
//

import Foundation

extension String {
//    时间转字符串
    func stringWithTime(time: TimeInterval) -> String {
        let min = Int(time / 60)
        let second = Int(time) % 60
        return String(format: "%02ld:%02ld", min, second)
    }
}

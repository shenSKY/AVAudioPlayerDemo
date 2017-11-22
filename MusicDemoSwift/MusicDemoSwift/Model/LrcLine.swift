//
//  LrcLine.swift
//  MusicDemoSwift
//
//  Created by 沈凯 on 2017/11/20.
//  Copyright © 2017年 Ssky. All rights reserved.
//

import UIKit

class LrcLine: NSObject {
//    时间
    var time: TimeInterval!
//    歌词
    var lrc: String!

    init(lrcString: String) {
        super.init()
        lrc = lrcString.components(separatedBy: "]").last
        let timeString = (lrcString.components(separatedBy: "]").first as NSString?)?.substring(from: 1)
        time = time(with: timeString!)
        
    }
    func time(with timeString: String) -> TimeInterval {
        let min = Int(timeString.components(separatedBy: ":").first!)
        let second = Int((timeString.components(separatedBy: ":").last!).components(separatedBy: ".").first!)
        let millisecond = Int((timeString.components(separatedBy: ":").last!).components(separatedBy: ".").last!)
        return TimeInterval(min! * 60 + second! + Int(Double(millisecond!) * 0.01))
    }
}

//
//  LrcTool.swift
//  MusicDemoSwift
//
//  Created by 沈凯 on 2017/11/20.
//  Copyright © 2017年 Ssky. All rights reserved.
//

import UIKit

class LrcTool: NSObject {
    class func getLrcsWithLrcName(_ lrcName: String) -> [LrcLine] {
//        获取歌词路径
    let lrcFilePath: String? = Bundle.main.path(forResource: lrcName, ofType: nil)
//        加载对应歌词
    let lrcString = try? String(contentsOfFile: lrcFilePath!, encoding: String.Encoding.utf8)
    let lrcs = lrcString?.components(separatedBy: "\n")
//        遍历歌词
    var tempArray = [Any]()
        for lrcLineString: String in lrcs! {
//            过滤不需要的信息(行号)
        if lrcLineString.hasPrefix("[ti:") || lrcLineString.hasPrefix("[ar:") || lrcLineString.hasPrefix("[al:") || !lrcLineString.hasPrefix("[") {
            continue
        }
//            每句歌词转模型
            let lrcLine = LrcLine.init(lrcString: lrcLineString)
            tempArray.append(lrcLine)
        }
        return tempArray as! [LrcLine]
    }
}

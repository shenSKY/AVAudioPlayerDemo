//
//  LrcLabel.swift
//  MusicDemoSwift
//
//  Created by 沈凯 on 2017/11/20.
//  Copyright © 2017年 Ssky. All rights reserved.
//

import UIKit

class LrcLabel: UILabel {
//    当前语句的进度
    var progress: CGFloat {
        set{
            setNeedsDisplay()
        }
        get{
            return self.progress
        }
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let drawRect = CGRect(x: 0, y: 0, width: bounds.size.width * progress, height: bounds.size.height)
        UIColor.green.set()
        UIRectFillUsingBlendMode(drawRect, .sourceIn)
    }
}

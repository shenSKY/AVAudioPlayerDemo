//
//  MusicModel.swift
//  MusicDemoSwift
//
//  Created by 沈凯 on 2017/11/13.
//  Copyright © 2017年 Ssky. All rights reserved.
//

import UIKit

class MusicModel: NSObject {
//    图片名字
    var icon: String!
//    歌名
    var name: String!
//    歌者
    var singer: String!
//    音乐名
    var filename: String!
//    歌词文件
    var lrcname: String!
//    歌者图片
    var singerIcon: String!
    
    override init() {
        super.init()
    }
    init(dic: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

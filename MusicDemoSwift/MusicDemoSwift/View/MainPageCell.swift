//
//  MainPageCell.swift
//  MusicDemoSwift
//
//  Created by 沈凯 on 2017/11/13.
//  Copyright © 2017年 Ssky. All rights reserved.
//

import UIKit

class MainPageCell: UITableViewCell {
//    图片
    @IBOutlet weak var img: UIImageView!
//    歌名
    @IBOutlet weak var songName: UILabel!
//    作者名
    @IBOutlet weak var singer: UILabel!
    
    var model: MusicModel {
        set {
            img.image = UIImage.init(named: newValue.singerIcon)
            songName.text = newValue.name
            singer.text = newValue.singer
        }
        get {
            return self.model
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

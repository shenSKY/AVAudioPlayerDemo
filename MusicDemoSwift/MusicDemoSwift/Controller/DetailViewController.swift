//
//  DetailViewController.swift
//  MusicDemoSwift
//
//  Created by 沈凯 on 2017/11/13.
//  Copyright © 2017年 Ssky. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    
    var model: MusicModel!
    var data: [MusicModel]!
    var currentIndex: NSInteger!
//    歌名
    @IBOutlet weak var MusicName: UILabel!
//    歌者
    @IBOutlet weak var singer: UILabel!
//    图片
    @IBOutlet weak var img: UIImageView!
//    进度
    @IBOutlet weak var progress: UISlider!
//    播放按钮
    @IBOutlet weak var playBtn: UIButton!
//    当前时间
    @IBOutlet weak var currentTime: UILabel!
//    总体时间
    @IBOutlet weak var totalTIme: UILabel!
//    歌词
    @IBOutlet weak var lrcLabel: LrcLabel!
//    歌词视图
    @IBOutlet weak var lrcView: LrcView!
//    播放器
    var audioPlayer: AVAudioPlayer!
//    进度的定时器
    var progressTimer: Timer!
//    歌词定时器
    var lrcTimer: CADisplayLink!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

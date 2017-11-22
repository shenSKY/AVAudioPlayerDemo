//
//  DetailViewController.swift
//  MusicDemoSwift
//
//  Created by 沈凯 on 2017/11/13.
//  Copyright © 2017年 Ssky. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class DetailViewController: UIViewController {
    
    var model: MusicModel!
    var data: [MusicModel]!
    var currentIndex: NSInteger!
//    歌名
    @IBOutlet weak var musicName: UILabel!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        becomeFirstResponder()
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resignFirstResponder()
        UIApplication.shared.endReceivingRemoteControlEvents()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        UI设置
        setUI()
//        播放音乐
        playMusic()
//        后台播放
        playingBackground()
//        设置进度定时器
        addProgressTimer()
//        设置歌词定时器
        addLrcTimer()
    }
//    MARK: UI设置
    func setUI() {
        setUIMessageWith(model)
        img.layer.masksToBounds = true
        img.layer.cornerRadius = CGFloat(UIScreen.main.bounds.size.width * 0.8 / 2)
        lrcView.contentSize = CGSize(width: view.bounds.size.width * 2, height: 0)
        lrcView.lrcLabel = lrcLabel
        lrcView.delegate = self
        lrcView.isPagingEnabled = true
        progress.setThumbImage(UIImage(named: "player_slider_playback_thumb"), for: .normal)
    }
//    MARK: 设置相关信息
    func setUIMessageWith(_ model: MusicModel) {
        musicName.text = model.name
        singer.text = model.singer
        img.image = UIImage.init(named: model.icon)
        lrcView.lrcName = model.lrcname
    }
//    MARK: 播放音乐
    func playMusic() {
        audioPlayer = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: model.filename, withExtension: nil)!)
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        }
//        获取音乐信息
        currentTime.text = String.stringWithTime(time: audioPlayer.currentTime)
        totalTIme.text = String.stringWithTime(time: audioPlayer.duration)
//        图片旋转动画
        img.layer.startAnimate()
        playBtn.isSelected = true
//        设置锁屏信息显示
        setLockScreenDisplay()
    }
//    MARK: 设置锁屏信息显示
    func setLockScreenDisplay() {
        var info = Dictionary<String, Any>()
        info[MPMediaItemPropertyTitle] = model.name//歌名
        info[MPMediaItemPropertyArtist] = model.singer//作者
//        [info setObject:self.model.filename forKey:MPMediaItemPropertyAlbumTitle];//专辑名
        info[MPMediaItemPropertyAlbumArtist] = model.singer//专辑作者
        info[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(image: UIImage.init(named: model.icon)!)//显示的图片
        info[MPMediaItemPropertyPlaybackDuration] = audioPlayer.duration//总时长
        info[MPNowPlayingInfoPropertyPlaybackRate] = 1.0//播放速率
        MPNowPlayingInfoCenter.default().nowPlayingInfo = info
    }
//    MARK: 后台播放
    func playingBackground() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(AVAudioSessionCategoryPlayback)
        try? session.setActive(true)
    }
//    MARK: 设置进度定时器
    func addProgressTimer() {
        progressTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateProgressInfo), userInfo: nil, repeats: true)
        RunLoop.main.add(progressTimer, forMode: .commonModes)
    }
//    MARK: 更新时间进度
    @objc func updateProgressInfo() {
        currentTime.text = String.stringWithTime(time: audioPlayer.currentTime)
        progress.value = Float(audioPlayer.currentTime / audioPlayer.duration)
    }
//    MARK: 设置歌词定时器
    func addLrcTimer() {
        lrcTimer = CADisplayLink(target: self, selector: #selector(self.updateLrc))
        lrcTimer.add(to: RunLoop.main, forMode: .commonModes)
    }
//    MARK: 更新歌词
    @objc func updateLrc() {
        lrcView.currentTime = audioPlayer.currentTime
    }
}
//    MARK: - UIScrollViewDelegate
extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        取出scrollView偏移量
        let Offset: CGPoint = scrollView.contentOffset
        let offsetRatio: CGFloat = Offset.x / scrollView.bounds.size.width
//        设置iconView和歌词Label的透明度
        img.alpha = 1 - offsetRatio
        lrcLabel.alpha = 1 - offsetRatio
    }
}
extension DetailViewController: AVAudioPlayerDelegate {
    
}

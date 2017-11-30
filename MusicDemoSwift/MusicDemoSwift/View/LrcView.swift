//
//  LrcView.swift
//  MusicDemoSwift
//
//  Created by 沈凯 on 2017/11/20.
//  Copyright © 2017年 Ssky. All rights reserved.
//

import UIKit

class LrcView: UIScrollView {
//    歌词名称
    var lrcName: String
    {
        set {
//            解析歌词
            lrcs = LrcTool.getLrcsWithLrcName(newValue)
//            刷新
            tableView.reloadData()
        }
        get {
            return self.lrcName
        }
    }
//    当前歌曲播放时间
    var currentTime: TimeInterval
    {
        set {
//            和数组中歌词的时间对比,找出应该显示的歌词
            let count = lrcs.count
    
            for i in 0..<count {
//                取出当前歌词
                let lrcLine = lrcs[i]
//                取出下一句歌词
                let nextIndex = i + 1
                if nextIndex > count - 1 {
                    return
                }
                let nextLrcLine = lrcs[nextIndex]
//                让当前播放时间和当前句歌词的时间和下一句歌词的时间对比,如果当前时间大于等于当前句歌词的时间,并且小于下一句歌词的时间,显示该句歌词
                if currentTime >= lrcLine.time && currentTime < nextLrcLine.time && currentIndex != i {
//                    获取前一句播放歌词的NSIndexPath
                    var indexs = [IndexPath]()
                    if currentIndex < count - 1 {
                        let previousIndexPath = IndexPath(row: currentIndex, section: 0)
                        indexs.append(previousIndexPath)
                    }
//                    记录当前播放句的下标值
                    currentIndex = i
//                    获取当前句的NSIndexPath
                    let indexPath = IndexPath(row: i, section: 0)
                    indexs.append(indexPath)
//                    刷新歌词
                    tableView.reloadRows(at: indexs, with: .none)
//                    让tableView的当前播放的句,滚动中间位置
                    tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//                    改变外面歌词Label显示的文字
                    lrcLabel.text = lrcLine.lrc
                }
//                如果正在更新某一句歌词
                if currentIndex == i {
//                    取出i位置的cell
                    let indexPath = IndexPath(row: i, section: 0)
                    let cell = tableView.cellForRow(at: indexPath) as? LrcCell
//                    更新cell中的lrcLabel的进度
                    cell?.lrcLabel.progress = CGFloat((currentTime - lrcLine.time) / (nextLrcLine.time - lrcLine.time))
//                    改变外面歌词Label显示的进度
                    lrcLabel.progress = CGFloat((currentTime - lrcLine.time) / (nextLrcLine.time - lrcLine.time))
                }
            }
        }
        get {
            return self.currentTime
        }
    }
//    外面的歌词
    var lrcLabel: LrcLabel!
//    显示歌词的TableView
    var tableView: UITableView!
//    歌词数据
    var lrcs: [LrcLine]!
//    当前正在播放的歌词下标
    var currentIndex: Int!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTableView()
        currentIndex = 0
    }
    func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        addSubview(tableView)
        tableView.register(UINib(nibName: "LrcCell", bundle: Bundle.main), forCellReuseIdentifier: "LrcCell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = CGRect.init(x: self.frame.size.width, y: 0, width: self.frame.size.width, height: self.frame.size.height)
//        设置多余的滑动区域
        tableView.contentInset = UIEdgeInsetsMake(bounds.size.height * 0.5, 0, bounds.size.height * 0.5, 0)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
    }
}
extension LrcView: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lrcs.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LrcCell") as! LrcCell
        if indexPath.row == currentIndex {
            cell.lrcLabel.font = UIFont.systemFont(ofSize: 18)
        }else {
            cell.lrcLabel.font = UIFont.systemFont(ofSize: 16)
            cell.lrcLabel.progress = 0
        }
        let lrcLine = lrcs[indexPath.row]
        cell.lrcLabel.text = lrcLine.lrc
        return cell
    }
}


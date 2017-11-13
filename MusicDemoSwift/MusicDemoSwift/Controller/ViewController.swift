//
//  ViewController.swift
//  MusicDemoSwift
//
//  Created by 沈凯 on 2017/11/13.
//  Copyright © 2017年 Ssky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    TableView
    @IBOutlet weak var tableView: UITableView!
//    懒加载数组
    lazy var data = [MusicModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        数据加载
        loadData()
//        注册Cell
        tableView.register(UINib(nibName: "MainPageCell", bundle: Bundle.main), forCellReuseIdentifier: "MainPageCell")
    }
//    MARK: - 数据加载
    func loadData() {
        let arr = NSMutableArray.init(contentsOfFile: Bundle.main.path(forResource: "Musics", ofType: "plist")!)
        for dic in arr! {
            let model = MusicModel.init(dic: dic as! [String : AnyObject])
            data.append(model)
        }
    }
}
//MARK: - TableView Delegate
extension ViewController: UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPageCell") as! MainPageCell
        cell.model = data[indexPath.row] 
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 118
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        vc.model = data[indexPath.row]
        vc.data = data as! NSMutableArray;
        vc.currentIndex = indexPath.row
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
}


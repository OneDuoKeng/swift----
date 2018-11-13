//
//  VideoListViewController.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/13.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON

class VideoListViewController: UIViewController {

    var special_id : Int?
    
    var dicData = MostRequestsViewModel()
    
    var detailDic : VideoListModel?
    
    var videoListArray = [VideoListModel]()
    
    var listTableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupUI()
        
        let special_idString : String = (self.special_id?.description)!
        
        self.dicData.loadAlbumDetailsData(albumDetailsID: special_idString) { (detailDic, videoListArray) in
            self.detailDic = detailDic
            self.videoListArray = videoListArray
            self.listTableView?.reloadData()
        }
    
    }
    
    func setupUI() {
        listTableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        listTableView?.delegate = self
        listTableView?.dataSource = self
        listTableView?.register(UINib.init(nibName: "ReuseImageCell", bundle: nil), forCellReuseIdentifier: "reuseImageCell")
        listTableView?.rowHeight = 220*proportionWidth
        self.view.addSubview(self.listTableView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension VideoListViewController : UITableViewDelegate, UITableViewDataSource  {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseImageCell", for: indexPath) as! ReuseImageCell
        
        cell.model = self.videoListArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = VideoPlaybackViewController()
        vc.videoUrl = self.videoListArray[indexPath.row].path
        self.present(vc, animated: true) {}
    }
    
    
}

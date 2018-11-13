//
//  VideoPlaybackViewController.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/13.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import WebKit


class VideoPlaybackViewController: UIViewController, MPlayerViewDelegate {

    var videoUrl : String?
    /** *播放器视图 */
    var playerView : MPlayerView?
    
    var webView : WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        self.playerView  = MPlayerView().initWithFrame(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: Screen_width * 9/16), videoUrl: self.videoUrl!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, type: "VIDEO")
        self.playerView?.mPlayerDelegate = self
        self.view.addSubview(self.playerView!)
    }
    ///MARK:播放器代理事件
    func closePlayer() {
        ///还可以做一些操作,比如清除单元格状态
        self.playerView = nil
    }
    
    func setBackgroundTime(_ currTime: Float, _ totTime: Float) {
        //        print("~~~~~当前时间!!!!!!总时间",currTime,totTime);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



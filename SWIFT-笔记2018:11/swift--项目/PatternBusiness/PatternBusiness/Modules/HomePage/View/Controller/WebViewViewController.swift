//
//  WebViewViewController.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/5/31.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit

class WebViewViewController: UIViewController {

    var urlString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let webView = UIWebView(frame: self.view.bounds)
        
        webView.loadRequest(URLRequest(url: URL(string: urlString!)!))
        
        self.view.addSubview(webView)
        
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

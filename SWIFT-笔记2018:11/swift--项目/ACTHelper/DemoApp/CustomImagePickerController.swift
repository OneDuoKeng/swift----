//
//  CustomImagePickerController.swift
//  DemoApp
//
//  Created by Jerry on 2017/5/16.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class CustomImagePickerController: UIImagePickerController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.tintColor = .black
        self.navigationBar.backgroundColor = .white
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        view.backgroundColor = .white
        self.view.addSubview(view)
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

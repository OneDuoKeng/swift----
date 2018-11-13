//
//  DetailViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/5/22.
//  Copyright © 2017年 www.coolketang.com. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var parameter : String!
    @IBOutlet var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.detailLabel.text = self.parameter
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

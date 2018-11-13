//
//  BaseLoginRegViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/24.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class BaseLoginRegViewController: BaseViewController {
    
    var focusedFieldType : FieldType = .Password
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.dismissBt.isHidden = true
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BaseLoginRegViewController.hideKeyboard)))
    }
    
    func hideKeyboard()
    {
        self.view.endEditing(true)
    }
    
    func checkForm()
    {
        
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

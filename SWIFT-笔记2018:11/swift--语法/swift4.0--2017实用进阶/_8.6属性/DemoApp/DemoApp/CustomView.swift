//
//  CustomView.swift
//  DemoApp
//
//  Created by Jerry on 2017/11/14.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class CustomView: UIView, UITextFieldDelegate {

    var textField : UITextField!
    weak var controller : ViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textField = UITextField(frame:CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.textColor = .purple
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        textField.layer.shadowOpacity = 0.45
        textField.layer.shadowRadius = 3
        textField.backgroundColor = .lightGray
        textField.delegate = self
        
        self.addSubview(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.controller?.checkForm()
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

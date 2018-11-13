//
//  RegStep5Controller.swift
//  DemoApp
//
//  Created by Jerry on 2017/3/31.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import Toaster
import PKHUD

class RegStep5Controller: BaseLoginRegViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var hasIcon : Bool = false
    var userInfo : UserInfo!
    var mainArea : UIView!
    var footArea : UIView!
    var rowNickName : FormRow!
    var submit : RegButton!
    var titleAvarta : UILabel!
    var iconCamera : UIImageView!
    var imagePickerController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.backBt.isHidden = true
        
        mainArea = UIView(frame: CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 350))
        self.view.addSubview(mainArea)
        
        titleAvarta = UILabel(frame: CGRect(x: 20, y: 0, width: self.view.frame.size.width - 40, height: 20))
        titleAvarta.font = UIFont.boldSystemFont(ofSize: 14)
        titleAvarta.textColor = UIColor.white
        titleAvarta.text = "上传头像"
        mainArea.addSubview(titleAvarta)
        
        rowNickName = FormRow(frame: CGRect(x: 0, y: 70, width: Int(self.view.frame.size.width), height: 90))
        rowNickName.setValueType(type: FieldType.NickName)
        rowNickName.controller = self
        mainArea.addSubview(rowNickName)
        
        let iconSize = 58
        let posX1 = Int(self.view.frame.size.width) - iconSize - 20
        iconCamera = UIImageView(image: UIImage(named: "iconCamera"))
        iconCamera.frame = CGRect(x: posX1, y: 56, width: 58, height: 58)
        iconCamera.isUserInteractionEnabled = true
        let guesture1 = UITapGestureRecognizer(target: self, action: #selector(RegStep5Controller.openAlbum(_:)))
        iconCamera.layer.cornerRadius = CGFloat(iconSize/2)
        iconCamera.layer.masksToBounds = true
        iconCamera.addGestureRecognizer(guesture1)
        
        self.view.addSubview(iconCamera)
        
        footArea = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - 60, width: self.view.frame.size.width, height: 60))
        self.view.addSubview(footArea)
        
        let posX3 = self.view.frame.size.width - 90 - 20
        submit = RegButton(frame: CGRect(x: posX3, y: 0, width: 90, height: 37))
        submit.bt.setTitle("下一步", for: .disabled)
        submit.bt.setTitle("下一步", for: .normal)
        submit.bt.addTarget(self, action: #selector(RegStep5Controller.submit(_:)), for: .touchUpInside)
        footArea.addSubview(submit)
        self.rowNickName.inputField.becomeFirstResponder()
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RegStep5Controller.keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RegStep5Controller.keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    // MARK:
    // MARK:keyboardWillShow
    func keyboardWillShow(_ notification: Notification?)
    {
        var keyboardH = Int(self.getKeyboardHeight())
        if(self.focusedFieldType == .NickName)
        {
            keyboardH += 30
        }
        if(self.view.frame.width == 414)
        {
            keyboardH += 10
        }
        
        let frame = CGRect(x: 0, y: Int(self.view.frame.size.height) - 60 - keyboardH, width: Int(self.view.frame.size.width), height: 60)
        
        UIView.beginAnimations("keyboardWillShow", context: nil)
        
        UIView.setAnimationDuration(0.2)
        self.footArea.frame = frame
        
        UIView.commitAnimations()
    }
    
    func keyboardWillHide(_ notification: Notification?)
    {
        let frame = CGRect(x: 0, y: Int(self.view.frame.size.height) - 60, width: Int(self.view.frame.size.width), height: 60)
        
        UIView.beginAnimations("keyboardWillShow", context: nil)
        UIView.setAnimationDuration(0.3)
        self.footArea.frame = frame
        
        
        UIView.commitAnimations()
    }
    
    // MARK:
    override func checkForm()
    {
        if rowNickName.isPass && hasIcon
        {
            self.submit.active()
        }
        else
        {
            self.submit.deActive()
        }
    }
    
    func checkFormAgain() -> Bool
    {
        rowNickName.isPass = false
        
        _ = rowNickName.checkValue()
        
        if rowNickName.isPass
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func submit(_ sender : UIButton)
    {
        if(!self.checkFormAgain())
        {
            self.submit.active()
            return
        }
        
        self.userInfo.nickname = self.rowNickName.getValue()
        
        let url = "\(self.baseUrl)iOS/nickname.json"
        let parameters = ["nickname": self.userInfo.nickname]
        
        HUD.show(.progress)
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON
            { response in
                
                print(response)
                HUD.hide(animated: true)
                
                if let json = response.result.value as? [String: Any]
                {
                    print("JSON: \(json)")
                    let code = json["code"] as? Int ?? 0
                    
                    if(code == 0)
                    {
                        DataUtil.setCrtUser(userInfo: self.userInfo)
                        
                        let vc = RegStep6Controller()
                        vc.userInfo = self.userInfo
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else
                    {
                        ToastView.appearance().font = self.font14
                        ToastView.appearance().bottomOffsetPortrait = 100
                        let detail = json["detail"] as? String ?? ""
                        Toast(text: detail).show()
                    }
                }
                else
                {
                    ToastView.appearance().font = self.font14
                    ToastView.appearance().bottomOffsetPortrait = 100
                    Toast(text: "服务器出错，请重新尝试。").show()
                }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openAlbum(_ gusture:UITapGestureRecognizer)
    {
        self.imagePickerController = CustomImagePickerController()
        self.imagePickerController.delegate = self
        self.imagePickerController.allowsEditing = true
        self.imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.imagePickerController.navigationBar.barTintColor = UIColor.orange
        self.imagePickerController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
        self.imagePickerController.navigationBar.tintColor = UIColor.black
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        hasIcon = true
        let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage
        let originImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        self.iconCamera.image = editedImage
        self.userInfo.avatar = self.iconCamera.image!
        
        self.checkForm()
        self.dismiss(animated: true, completion: nil)
        
        DataUtil.uploadAvartaToQiNiu(baseUrl: self.baseUrl, avarta: self.iconCamera.image!)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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

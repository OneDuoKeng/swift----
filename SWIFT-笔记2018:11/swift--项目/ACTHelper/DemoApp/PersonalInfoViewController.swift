//
//  PersonalInfoViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/5/3.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import Toaster
import PKHUD

class PersonalInfoViewController: BaseViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var isUpdatingNickName = false
    var PaperType : PaperType = .ACT
    var inputArea : UIScrollView!
    var inputAreaFrame : CGRect!
    var nickNameTextfield : UITextField!
    var avartaImage : UIImageView!
    var scoreViewACT : ACTScoreInputViewBlack!
    var scoreViewSAT : SATScoreInputViewBlack!
    var imagePickerController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.layer.sublayers?[0].removeFromSuperlayer()
        self.view.backgroundColor = .white
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let image = UIImage(named: "LeftArrowDrakGray")
        self.backBt.setImage(image, for: .normal)
        
        let topBar = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.height, height: 64))
        topBar.backgroundColor = UIColor.white
        self.view.insertSubview(topBar, belowSubview: self.backBt)
        
        let topTitle = UILabel(frame: CGRect(x: 0, y: 32, width: self.widthFull, height: 18))
        topTitle.text = "个人信息"
        topTitle.font = self.font17
        topTitle.textColor = self.fontColorDarkGray
        topTitle.textAlignment = .center
        topBar.addSubview(topTitle)
        
        let split = UIView(frame: CGRect(x: 0, y: 63, width: self.widthFull, height: 1))
        split.backgroundColor = self.fontColorLightGray
        topBar.addSubview(split)
        
        inputAreaFrame = CGRect(x: 0, y: 64, width: self.widthFull, height: self.heightFull - 64)
        inputArea = UIScrollView(frame: inputAreaFrame)
        //inputArea.backgroundColor = .orange
        inputArea.contentInset = UIEdgeInsets(top: -24, left: 0, bottom: 0, right: 0)
        self.view.insertSubview(inputArea, belowSubview: topBar)
        
        let lblAvarta = UILabel(frame: CGRect(x: 20, y: 48, width: 58, height: 20))
        lblAvarta.text = "用户头像"
        lblAvarta.textColor = self.fontColorDarkGray
        lblAvarta.font = self.font14
        inputArea.addSubview(lblAvarta)
        
        let posX = self.widthFull - 58 - 20
        avartaImage = UIImageView(frame: CGRect(x: posX, y: 30, width: 58, height: 58))
        avartaImage.layer.cornerRadius = 29.0
        avartaImage.layer.masksToBounds = true
        avartaImage.isUserInteractionEnabled = true
        let guesture1 = UITapGestureRecognizer(target: self, action: #selector(PersonalInfoViewController.openAlbum(_:)))
        avartaImage.addGestureRecognizer(guesture1)
        inputArea.addSubview(avartaImage)
        
        let split2 = UIView(frame: CGRect(x: 20, y: 110, width: width40, height: 1))
        split2.backgroundColor = self.fontColorLightGray
        inputArea.addSubview(split2)
        
        let lblName = UILabel(frame: CGRect(x: 20, y: 131, width: width40, height: 20))
        lblName.text = "用户昵称"
        lblName.font = self.font14
        lblName.textColor = self.fontColorDarkGray
        inputArea.addSubview(lblName)
        
        let userInfo = DataUtil.getCrtUser()
        let posX2 = 20 + 80
        let width = self.width40 - 80
        nickNameTextfield = UITextField(frame: CGRect(x: posX2, y: 121, width: width, height: 40))
        nickNameTextfield.font = self.font14
        nickNameTextfield.textAlignment = .right
        nickNameTextfield.returnKeyType = .done
        nickNameTextfield.delegate = self
        nickNameTextfield.tag = 1
        nickNameTextfield.textColor = self.fontColorBlue
        nickNameTextfield.text = userInfo.nickname
        inputArea.addSubview(nickNameTextfield)
        
        let split3 = UIView(frame: CGRect(x: 20, y: 172, width: width40, height: 1))
        split3.backgroundColor = self.fontColorLightGray
        inputArea.addSubview(split3)
        
        if(userInfo.exam_type == 0)
        {
            self.PaperType = .ACT
        }
        else
        {
            self.PaperType = .SAT
        }
        
        if(self.PaperType == .ACT)
        {
            scoreViewACT = ACTScoreInputViewBlack(frame: CGRect(x: 0, y: 174, width: Int(self.view.frame.size.width), height: 308))
            scoreViewACT.buildUIWithController(controller: self)
            let scores = [userInfo.current_score, userInfo.english, userInfo.math, userInfo.reading, userInfo.science]
            scoreViewACT.setScores(scores: scores)
            inputArea.contentSize = CGSize(width: widthFull, height: 500)
            inputArea.addSubview(scoreViewACT)
        }
        else
        {
            scoreViewSAT = SATScoreInputViewBlack(frame: CGRect(x: 0, y: 174, width: Int(self.view.frame.size.width), height: 188))
            scoreViewSAT.buildUIWithController(controller: self)
            let scores = [userInfo.reading, userInfo.math, userInfo.writing]
            scoreViewSAT.setScores(scores: scores)
            inputArea.contentSize = CGSize(width: widthFull, height: 410)
            inputArea.addSubview(scoreViewSAT)
        }
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PersonalInfoViewController.hideKeyboard)))
        
        
        DataUtil.setAvartaForImageView(imageView: self.avartaImage)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.hideTabBar()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        updateNickName(textField: textField)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateNickName(textField: textField)
    }
    
    //MARK:
    //MARK:updateNickName
    func updateNickName(textField: UITextField)
    {
        if(textField.tag == 1)
        {
            hideKeyboard()
            
            if(textField.text != "")
            {
                updateNickNameToServer(nickName: textField.text!)
            }
            else
            {
                Toast(text: "用户昵称不能为空！").show()
            }
        }
    }
    
    func updateNickNameToServer(nickName: String)
    {
        if(isUpdatingNickName)
        {
            return
        }
        
        isUpdatingNickName = true
        let userInfo = DataUtil.getCrtUser()
        let parameters = ["nickname": nickName]
        let url = "\(self.baseUrl)iOS/userInfo.json"
        
        HUD.show(.progress)
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON
            { response in
                
                HUD.hide(animated: true)
                
                if let json = response.result.value as? [String: Any]
                {
                    print("JSON: \(json)")
                    let code = json["code"] as? Int ?? 0
                    let detail = json["detail"] as? String ?? ""
                    
                    self.isUpdatingNickName = false
                    ToastView.appearance().bottomOffsetPortrait = 80
                    if(code == 0)
                    {
                        let userInfo = DataUtil.getCrtUser()
                        userInfo.nickname = nickName
                        DataUtil.setCrtUser(userInfo: userInfo)
                        
                        ToastView.appearance().font = self.font14
                        Toast(text: "用户昵称更换成功！", duration: Delay.short).show()
                    }
                    else
                    {
                        Toast(text: detail).show()
                    }
                }
        }
    }
    
    func hideKeyboard()
    {
        if(self.PaperType == .ACT)
        {
            self.scoreViewACT.hidePicker2()
        }
        self.view.endEditing(true)
    }
    
    
    //MARK:
    //MARK:打开相册
    func openAlbum(_ gusture:UITapGestureRecognizer)
    {
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.delegate = self
        self.imagePickerController.allowsEditing = true
        self.imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.imagePickerController.navigationBar.barTintColor = UIColor.orange
        self.imagePickerController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
        self.imagePickerController.navigationBar.tintColor = UIColor.black
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        self.avartaImage.image = info["UIImagePickerControllerEditedImage"] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
        
        DataUtil.uploadAvartaToQiNiu(baseUrl: self.baseUrl, avarta: self.avartaImage.image!)
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

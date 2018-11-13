//
//  MySettingsViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/5/2.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
import Toaster
import StoreKit

class MySettingsViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var lblName : UILabel!
    var imgAvarta : UIImageView!
    var btProfile : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backBt.isHidden = true
        self.view.layer.sublayers?[0].removeFromSuperlayer()
        self.view.backgroundColor = .white
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default

        // Do any additional setup after loading the view.
        let iconSize = 58
        let lblNameW = self.width40 - iconSize
        lblName = UILabel(frame: CGRect(x: 20, y: 76, width: lblNameW, height: 28))
        lblName.text = "您的昵称"
        lblName.textColor = self.fontColorDarkGray
        lblName.font = self.font24
        self.view.addSubview(lblName)
        
        btProfile = UIButton(frame: CGRect(x: 20, y: 105, width: 156, height: 39))
        btProfile.setTitle("查看并编辑个人资料", for: .normal)
        btProfile.titleLabel?.font = self.font17
        btProfile.titleLabel?.textColor = self.fontColorBlue
        btProfile.setTitleColor(self.fontColorBlue, for: .normal)
        btProfile.addTarget(self, action: #selector(MySettingsViewController.editProfile(_:)), for: .touchUpInside)
        btProfile.contentHorizontalAlignment = .left
        self.view.addSubview(btProfile)
        
        let posX = Int(self.view.frame.size.width) - 20 - iconSize
        self.imgAvarta = UIImageView(frame: CGRect(x: posX, y: 73, width: iconSize, height: iconSize))
        self.imgAvarta.image = UIImage(named: "defaultAvarta")
        self.imgAvarta.layer.cornerRadius = CGFloat(iconSize/2)
        self.imgAvarta.layer.masksToBounds = true
        self.view.addSubview(self.imgAvarta)
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 160, width: self.view.frame.size.width, height: self.view.frame.size.height - 160))
        self.view.addSubview(scrollView)
        
        let btAccountSetting = UIButton(frame: CGRect(x: 20, y: 0, width: self.width40, height: 58))
        btAccountSetting.titleLabel?.font = self.font17
        btAccountSetting.setTitleColor(self.fontColorDarkGray, for: .normal)
        btAccountSetting.setTitle("账号设置", for: .normal)
        btAccountSetting.contentHorizontalAlignment = .left
        btAccountSetting.addTarget(self, action: #selector(MySettingsViewController.accountSetting(_:)), for: .touchUpInside)
        scrollView.addSubview(btAccountSetting)
        
        let split1 = UIView(frame: CGRect(x: 20, y: 58, width: self.width40, height: 1))
        split1.backgroundColor = self.fontColorLightGray
        scrollView.addSubview(split1)
        
        let sizeArrow = 28
        let posArrowX = Int(self.view.frame.size.width) - 20 - sizeArrow
        let arrow1 = UIImageView(image: UIImage(named: "rightArrowBlack"))
        arrow1.frame = CGRect(x: posArrowX, y: 15, width: sizeArrow, height: sizeArrow)
        scrollView.addSubview(arrow1)
        
        
        let btFeedback = UIButton(frame: CGRect(x: 20, y: 58, width: self.width40, height: 58))
        btFeedback.titleLabel?.font = self.font17
        btFeedback.setTitleColor(self.fontColorDarkGray, for: .normal)
        btFeedback.setTitle("向我们反馈", for: .normal)
        btFeedback.contentHorizontalAlignment = .left
        btFeedback.addTarget(self, action: #selector(MySettingsViewController.feedback(_:)), for: .touchUpInside)
        scrollView.addSubview(btFeedback)
        
        let split2 = UIView(frame: CGRect(x: 20, y: 58*2, width: self.width40, height: 1))
        split2.backgroundColor = self.fontColorLightGray
        scrollView.addSubview(split2)
        
        let arrow2 = UIImageView(image: UIImage(named: "rightArrowBlack"))
        arrow2.frame = CGRect(x: posArrowX, y: 15 + 58, width: sizeArrow, height: sizeArrow)
        scrollView.addSubview(arrow2)
        
        
        let btPingFen = UIButton(frame: CGRect(x: 20, y: 58*2, width: self.width40, height: 58))
        btPingFen.titleLabel?.font = self.font17
        btPingFen.setTitleColor(self.fontColorDarkGray, for: .normal)
        btPingFen.setTitle("给个好评吧", for: .normal)
        btPingFen.contentHorizontalAlignment = .left
        btPingFen.addTarget(self, action: #selector(MySettingsViewController.pingFen(_:)), for: .touchUpInside)
        scrollView.addSubview(btPingFen)
        
        let split3 = UIView(frame: CGRect(x: 20, y: 58*3, width: self.width40, height: 1))
        split3.backgroundColor = self.fontColorLightGray
        scrollView.addSubview(split3)
        
        let btShare = UIButton(frame: CGRect(x: 20, y: 58*3, width: self.width40, height: 58))
        btShare.titleLabel?.font = self.font17
        btShare.setTitleColor(self.fontColorDarkGray, for: .normal)
        btShare.setTitle("分享给朋友", for: .normal)
        btShare.contentHorizontalAlignment = .left
        btShare.addTarget(self, action: #selector(MySettingsViewController.share(_:)), for: .touchUpInside)
        scrollView.addSubview(btShare)
        
        let split4 = UIView(frame: CGRect(x: 20, y: 58*4, width: self.width40, height: 1))
        split4.backgroundColor = self.fontColorLightGray
        scrollView.addSubview(split4)
        
    }
        
    func loadUserInfo()
    {
        if DataUtil.isVisitorLogin()
        {
            self.lblName.text = "游客"
            self.btProfile.setTitle("返回并重新登陆", for: .normal)
        }
        else
        {
            let user = DataUtil.getCrtUser()
            self.lblName.text = user.nickname
            
            DataUtil.setAvartaForImageView(imageView: self.imgAvarta)
        }
        
    }
    
    func editProfile(_ sender: UIButton)
    {
        if DataUtil.isVisitorLogin()
        {
            self.goBackToLogin()
        }
        else
        {
            let vc = PersonalInfoViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func accountSetting(_ sender: UIButton)
    {
        if DataUtil.isVisitorLogin()
        {
            self.alertWhenYouKe()
        }
        else
        {
            let vc = AccountSettingsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func alertWhenYouKe()
    {
        let alert = UIAlertController(title: "提示", message: "该功能仅限登陆会员使用，\n您需要重新登陆吗?", preferredStyle: UIAlertControllerStyle.alert)
        
        let yes = UIAlertAction(title: "是", style: UIAlertActionStyle.default, handler: {(alerts: UIAlertAction) -> Void in
            
            self.goBackToLogin()
        })
        
        let no = UIAlertAction(title: "否", style: UIAlertActionStyle.default, handler: {(alerts: UIAlertAction) -> Void in
            
        })
        
        alert.addAction(yes)
        alert.addAction(no)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func goBackToLogin()
    {
        let storyBoard = UIStoryboard(name: "RegLogin", bundle: nil)
        let vc = storyBoard.instantiateInitialViewController()
        let navigationController = UINavigationController(rootViewController: vc!)
        UIApplication.shared.delegate?.window??.rootViewController = navigationController
    }
    
    func feedback(_ sender: UIButton)
    {
        let vc = FeedBackViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pingFen(_ sender: UIButton)
    {
        if #available(iOS 10.3, *)
        {
            SKStoreReviewController.requestReview()
        }
        else
        {
            let url = URL(string: "itms-apps://itunes.apple.com/app/id1063100471")
            UIApplication.shared.openURL(url!)
        }
    }
    
    func share(_ sender: UIButton)
    {
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: "我正在使用酷课堂，这是一个很棒的ACT&SAT学习平台，你也下载使用吧！",
                                          images : UIImage(named: "Logo180.png"),
                                          url : NSURL(string:"https://itunes.apple.com/cn/app/id1063100471") as URL!,
                                          title : "酷课堂 - ACT&SAT",
                                          type : SSDKContentType.auto)
        
        SSUIShareActionSheetStyle.setShareActionSheetStyle(.simple)
        ShareSDK.showShareActionSheet(nil, items: nil, shareParams: shareParames, onShareStateChanged: nil)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showTabBar()
        
        loadUserInfo()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
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

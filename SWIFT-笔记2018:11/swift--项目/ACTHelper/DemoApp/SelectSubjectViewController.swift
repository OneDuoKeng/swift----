//
//  SelectSubjectViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/14.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class SelectSubjectViewController: BaseViewController {

    weak var preController : JieXiViewController! = nil
    var checkAct : CustomCheckBox!
    var checkSat : CustomCheckBox!
    var activeIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.backBt.isHidden = true
        
        let upArrowBt = UIButton(frame: CGRect(x: 20, y: 25, width: 33, height: 33))
        upArrowBt.setImage(UIImage(named:"UpArrow"), for: .normal)
        upArrowBt.addTarget(self, action: #selector(JieXiViewController.tapFIlterBar(_:)), for: .touchUpInside)
        self.view.addSubview(upArrowBt)
        
        checkAct = CustomCheckBox(frame: CGRect(x: 20, y: 68, width: self.view.frame.size.width-40, height: 45))
        checkAct.setTitle(title: "ACT")
        let guesture = UITapGestureRecognizer(target: self, action: #selector(SelectSubjectViewController.selecACT(_:)))
        checkAct.addGestureRecognizer(guesture)
        
        self.view.addSubview(checkAct)
        
        checkSat = CustomCheckBox(frame: CGRect(x: 20, y: 123, width: self.view.frame.size.width-40, height: 45))
        checkSat.setTitle(title: "SAT")
        let guesture2 = UITapGestureRecognizer(target: self, action: #selector(SelectSubjectViewController.selecSAT(_:)))
        checkSat.addGestureRecognizer(guesture2)
        self.view.addSubview(checkSat)
        
        let posX = self.view.frame.size.width - 20 - 56
        let btClear = UIButton(frame: CGRect(x: posX, y: 22, width: 56, height: 40))
        btClear.setTitle("清除选择", for: .normal)
        btClear.titleLabel?.textColor = .white
        btClear.titleLabel?.font = self.font14
        btClear.addTarget(self, action: #selector(SelectSubjectViewController.clearSelect(_:)), for: .touchUpInside)
        self.view.addSubview(btClear)
        
        if(activeIndex == 1)
        {
            checkAct.active()
            checkSat.deActive()
        }
        else if(activeIndex == 2)
        {
            checkAct.deActive()
            checkSat.active()
        }
    }
    
    func clearSelect(_ sender:UIButton)
    {
        checkAct.deActive()
        checkSat.deActive()
        
        preController.crtKeMu = ""
        preController.crtTiKu = ""
        preController.setFilterLabel()
        preController.loadShiJuanList()
        self.dismiss(animated: true, completion: nil)
    }
    
    func tapFIlterBar(_ sender:UIButton)
    {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func selecACT(_ gusture:UITapGestureRecognizer)
    {
        checkAct.active()
        checkSat.deActive()
        
        if self.activeIndex != 1
        {
            preController.crtKeMu = "ACT"
            preController.crtTiKu = ""
            preController.crtShiJuan = ""
            preController.crtShiJuanUUId = ""
            preController.setFilterLabel()
            preController.loadShiJuanList()
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func selecSAT(_ gusture:UITapGestureRecognizer)
    {
        checkAct.deActive()
        checkSat.active()
        
        if self.activeIndex != 2
        {
            preController.crtKeMu = "SAT"
            preController.crtTiKu = ""
            preController.crtShiJuan = ""
            preController.crtShiJuanUUId = ""
            preController.setFilterLabel()
            preController.loadShiJuanList()
        }
        
        self.dismiss(animated: true, completion: nil)
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

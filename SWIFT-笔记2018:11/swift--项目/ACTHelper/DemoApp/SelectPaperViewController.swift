//
//  SelectTiKuViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/14.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire

struct Paper
{
    var title: String
    var uuid: String
}

class SelectPaperViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tabType = TabType.Analysis
    var crtKeMu = "ACT"
    var crtTiKu = ""
    var crtShiJua = ""
    var crtShiJuanIndexPath = 0
    var tipLabel : UILabel!
    var originList : Array<String> = []
    var originSubList : Array<Array<Paper>> = []
    var selectedDiQuList : Array<Paper> = []
    var tableView : UITableView!
    weak var preController : JieXiViewController! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.backBt.isHidden = true
        
        let upArrowBt = UIButton(frame: CGRect(x: 20, y: 25, width: 33, height: 33))
        upArrowBt.setImage(UIImage(named:"UpArrow"), for: .normal)
        upArrowBt.addTarget(self, action: #selector(JieXiViewController.tapFIlterBar(_:)), for: .touchUpInside)
        self.view.addSubview(upArrowBt)
        
        var url = "\(self.baseUrl)iOS/act_index.json"
        if(crtKeMu == "SAT")
        {
            url = "\(self.baseUrl)iOS/sat_index.json"
        }
        else
        {
            crtKeMu = "ACT"
        }
        
        HUD.show(.progress)
        Alamofire.request(url).responseJSON
            { response in
                
                HUD.hide(animated: true)
                
                if let json = response.result.value as? [[String: Any]]
                {
                    let posX = self.view.frame.size.width - 20 - 56
                    let btClear = UIButton(frame: CGRect(x: posX, y: 22, width: 56, height: 40))
                    btClear.setTitle("清除选择", for: .normal)
                    btClear.titleLabel?.textColor = .white
                    btClear.titleLabel?.font = self.font14
                    btClear.addTarget(self, action: #selector(SelectPaperViewController.clearSelect(_:)), for: .touchUpInside)
                    self.view.addSubview(btClear)
                    
                    self.initOriginList(json: json)
                    
                    var buttonW = self.view.frame.size.width - 20*3
                    buttonW = buttonW/2
                    var baseX = 20
                    var baseY = 68
                    for i in 0...self.originList.count-2
                    {
                        if(i % 2 == 0)
                        {
                            baseX = 20
                        }
                        else
                        {
                            baseX = 20 + Int(buttonW) + 20
                        }
                        if(i > 0 && i % 2 == 0)
                        {
                            baseY += 55
                        }
                        let frame = CGRect(x: baseX, y: baseY, width: Int(buttonW), height: 45)
                        let checkBox = CustomCheckBox(frame: frame)
                        checkBox.setTitle(title: self.originList[i])
                        checkBox.tag = i+1
                        
                        let guesture = UITapGestureRecognizer(target: self, action: #selector(SelectPaperViewController.tapCheckbox(_:)))
                        checkBox.addGestureRecognizer(guesture)
                        
                        if(self.crtTiKu == self.originList[i])
                        {
                            checkBox.active()
                            self.selectedDiQuList = self.originSubList[i]
                        }
                        self.view.addSubview(checkBox)
                        
                    }
                    
                    self.createList()
                    
                }
                else
                {
                    let label = UILabel(frame: CGRect(x: 20, y: 80, width: 100, height: 20))
                    label.text = "暂无数据"
                    label.font = self.font14
                    label.textColor = .white
                    label.textAlignment = .left
                    
                    self.view.addSubview(label)
                }
        }
        
    }
    
    func initOriginList(json: [[String: Any]])
    {
        for i in 0...json.count-1
        {
            let origin = json[i]["origin"]
            self.originList.append(origin as! String)
        }
        
        self.originList = self.originList.distinct({$0})
        self.originList.sort(by: {$0 < $1})
        
        self.originSubList.append(Array<Paper>())
        self.originSubList.append(Array<Paper>())
        self.originSubList.append(Array<Paper>())
        self.originSubList.append(Array<Paper>())
        
        for i in 0...json.count-1
        {
            let title = json[i]["title"] as! String
            let origin = json[i]["origin"] as! String
            let uuid = json[i]["uuid"] as! String
            for j in 0...self.originList.count-2
            {
                if origin == self.originList[j]
                {
                    self.originSubList[j].append(Paper(title: title, uuid: uuid))
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.selectedDiQuList.count > 0
        {
            for i in 0...self.selectedDiQuList.count-1
            {
                let paper = self.selectedDiQuList[i]
                if paper.title == self.crtShiJua
                {
                    self.crtShiJuanIndexPath = i
                }
            }
            
            if(self.crtShiJuanIndexPath > 7)
            {
                let indexPath = IndexPath(row: self.crtShiJuanIndexPath-2, section: 0)
                tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
            }
        }
    }
    
    func clearSelect(_ sender:UIButton)
    {
        self.unCheckAll()
        
        self.selectedDiQuList = Array<Paper>()
        self.tableView.reloadData()
        self.showOrHideTipLabel()
    }
    
    func createList()
    {
        let split = UIView(frame: CGRect(x: 0, y: 190, width: self.view.frame.size.width, height: 1))
        split.backgroundColor = UIColor(red: 230.0/255, green: 230.0/255, blue: 230.0/255, alpha: 0.5)
        self.view.addSubview(split)
        
        tipLabel = UILabel(frame: CGRect(x: 20, y: 210, width: self.view.frame.size.width-40, height: 28))
        tipLabel.text = "请选择想要查看的题库"
        tipLabel.textColor = UIColor.white
        tipLabel.font = UIFont(name: "PingFang SC", size: 20)
        self.showOrHideTipLabel()
        self.view.addSubview(tipLabel)
        
        let posY = Int(68 + 20 + (self.originList.count/2)*55)
        let frame = CGRect(x: 5, y: posY, width: Int(self.view.frame.width-25), height: Int(self.view.frame.height)-posY)
        tableView = UITableView(frame: frame)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        
        let footView = UIView()
        footView.backgroundColor = UIColor.clear
        tableView.tableFooterView = footView
        self.view.addSubview(tableView)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedDiQuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "reusedCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            let icon = UIImageView(image: UIImage(named: "iconArrowWhite"))
            let posX = Int(self.view.frame.width-25-15)
            icon.frame = CGRect(x: posX, y: 15, width: 15, height: 15)
            icon.isHidden = true
            icon.tag = 1
            cell?.addSubview(icon)
        }
        
        let rowNum = (indexPath as NSIndexPath).row
        let paper = self.selectedDiQuList[rowNum]
        cell?.textLabel?.text = paper.title
        if(paper.title == self.crtShiJua)
        {
            cell?.viewWithTag(1)?.isHidden = false
        }
        else
        {
            cell?.viewWithTag(1)?.isHidden = true
        }
        cell?.textLabel?.font = UIFont(name: "PingFang SC", size: 14)
        cell?.textLabel?.textColor = UIColor.white
        cell?.backgroundColor = UIColor.clear
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        preController.crtKeMu = self.crtKeMu
        preController.crtTiKu = self.crtTiKu
        
        let paper = selectedDiQuList[indexPath.row]
        preController.crtShiJuan = paper.title
        preController.crtShiJuanUUId = paper.uuid
        
        preController.setFilterLabel()
        preController.loadPassageList()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func tapFIlterBar(_ sender:UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tapCheckbox(_ gusture:UITapGestureRecognizer)
    {
        self.unCheckAll()
        
        let view = gusture.view as! CustomCheckBox
        view.active()
        
        let tag = view.tag-1
        self.crtTiKu = view.titleLabel.text!
        self.selectedDiQuList = self.originSubList[tag]
        self.tableView.reloadData()
        self.showOrHideTipLabel()
    }
    
    func unCheckAll()
    {
        for i in 1...4
        {
            let view = self.view.viewWithTag(i) as! CustomCheckBox
            view.deActive()
        }
    }
    
    func showOrHideTipLabel()
    {
        if(self.selectedDiQuList.count == 0)
        {
            tipLabel.isHidden = false
        }
        else
        {
            tipLabel.isHidden = true
        }
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

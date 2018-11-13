//
//  ArticleViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/19.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
import Toaster

class ArticleViewController: BaseViewController {

    var questionTitle : String = ""
    var questionId : String = ""
    var articleView : UIWebView!
    var answerWebView : UIWebView!
    var split : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.sublayers?[0].removeFromSuperlayer()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        self.view.backgroundColor = .white
        self.backBt.isHidden = true
        self.dismissBt.isHidden = false
        
        let width = self.view.frame.size.width-40
        let tiMuTitle = UILabel(frame: CGRect(x: 20, y: 62, width: width, height: 28))
        tiMuTitle.text = self.questionTitle
        tiMuTitle.font = self.font20
        tiMuTitle.textColor = self.fontColorDarkGray
        self.view.addSubview(tiMuTitle)
        
        var dis320 : CGFloat = 0
        if(self.view.frame.size.width == 320)
        {
            dis320 = 20
        }
        var distance :CGFloat = 0
        if self.widthFull == 375
        {
            distance = 40
        }
        else if self.widthFull == 414
        {
            distance = 80
        }
        self.articleView = UIWebView(frame: CGRect(x: 20, y: 108 - dis320, width: width, height: CGFloat(243 + distance)))
        self.articleView.scrollView.contentInset = .init(top: 0, left: -4, bottom: 0, right: 0)
        self.articleView.backgroundColor = UIColor.clear
        
        self.articleView.subviews.forEach {
            if $0.isKind(of: NSClassFromString("UIScrollView")!)
            {
                $0.subviews.forEach {
                    if $0.isKind(of: NSClassFromString("UIImageView")!)
                    {
                        $0.isHidden = true
                    }
                }
            }
        }
        self.view.addSubview(self.articleView)
        
        split = UIView(frame: CGRect(x: 20, y: 372 - dis320 + distance, width: width, height: 1))
        split.backgroundColor = self.fontColorLightGray
        self.view.addSubview(split)
        
        self.answerWebView = UIWebView(frame: CGRect(x: 20, y: Int(382 - dis320 + distance), width: Int(width), height: Int(self.view.frame.size.height - 382 - distance)))
        answerWebView.backgroundColor = UIColor.clear
        answerWebView.scrollView.contentInset = articleView.scrollView.contentInset
        answerWebView.subviews.forEach {
            if $0.isKind(of: NSClassFromString("UIScrollView")!)
            {
                $0.subviews.forEach {
                    if $0.isKind(of: NSClassFromString("UIImageView")!)
                    {
                        $0.isHidden = true
                    }
                }
            }
        }
        
        self.view.addSubview(answerWebView)
        
        let resourceURL = Bundle.main.resourceURL
        self.answerWebView.loadHTMLString("", baseURL: resourceURL)
        
        self.loadData()
    }
    
    func loadData()
    {
        //该网址用来测试英文题目
        let urlEnglish = "\(self.baseUrl)iOS/articleEnglish.json"
        
        //该网址用来测试数学题目
        //let urlMath = "\(self.baseUrl)iOS/articleMath.json"
        
        HUD.show(.progress)
        Alamofire.request(urlEnglish).responseJSON
            { response in
                debugPrint(response)
                HUD.hide(animated: true)
                if let json = response.result.value as? [String: Any]
                {
                    var article = "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\">"
                    
                    article += "<script>"
                    article += "var aniNode=new Array();var time=0;var timeAni;"
                    article += "function scrollToQuestion(num, qid){"
                    article += "var svg = document.getElementsByClassName(\"question-anchor\");"
                    article += "for(var i=0; i<svg.length; i++){"
                    article += "var id = svg[i].getAttribute(\"qid\");"
                    article += "if(id == qid){"
                    article += "aniNode.push(svg[i]);"
                    article += "svg[i].style.fill=\"#ff0000\";"
                    article += "var firstChild = svg[i].firstChild;"
                    article += "var transform = firstChild.getAttribute(\"transform\");"
                    article += "var parts = transform.split(' ');"
                    article += "var posY = parts[1].replace(')','');"
                    article += "}}"
                    article += "document.getElementById(\"workArticle\").scrollTop=posY*0.9 - 120;"
                    article += "timeAni = self.setInterval(\"blinkNode()\",300);}"
                    
                    article += "function blinkNode(){"
                    article += "if(time % 2== 0){aniNode[0].style.fill=\"#000000\";"
                    article += "if(aniNode.length > 1){aniNode[1].style.fill=\"#000000\"}"
                    article += "}else{"
                    article += "aniNode[0].style.fill=\"#ff0000\";"
                    article += "if(aniNode.length > 1){aniNode[1].style.fill=\"#ff0000\"}"
                    article += "}time += 1;if(time == 8){window.clearInterval(timeAni)}}"
                    article += "</script>"
                    article += "<style>img{width:100%}</style>"
                    
                    let resourceURL = Bundle.main.resourceURL
                    if let content = json["passage"] as? String
                    {
                        if content.components(separatedBy: "/files/inline-images").count == 1
                        {
                            if self.questionTitle.components(separatedBy: "阅读").count == 1
                            {
                                article += "<style>#workArticle{overflow-x:hidden;}</style>"
                            }
                            
                        }
                        article += "<body onload=\"scrollToQuestion(1, '\(self.questionId)')\"><div id=\"workArticle\" style=\"height:400px\">"
                        article += content
                        if self.widthFull == 414
                        {
                            article = article.replacingOccurrences(of: "scale(1.25)", with: "scale(1.0)")
                        }
                        else
                        {
                            article = article.replacingOccurrences(of: "scale(1.25)", with: "scale(0.9)")
                        }
                        
                        article = article.replacingOccurrences(of: "svg xmlns", with: "svg style=\"font-family:Helvetica\" xmlns")
                        article = article.replacingOccurrences(of: "/files/inline-images", with: "http://www.coolketang.com/files/inline-images")
                        
                        article += "</div></body></html>"
                        
                        self.articleView.loadHTMLString(article, baseURL: resourceURL)
                    }
                    else
                    {
                        self.articleView.isHidden = true
                        self.split.isHidden = true
                        
                        var frame = self.articleView.frame
                        frame.size.height += (self.answerWebView.frame.size.height + 40)
                        self.answerWebView.frame = frame
                    }
                    
                    let description = json["description"] as? String
                    var html = "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\">"
                    
                    var isMathOrScience = false
                    if self.questionTitle.components(separatedBy: "数学").count > 1 || self.questionTitle.components(separatedBy: "科学").count > 1
                    {
                        isMathOrScience = true
                    }
                    
                    if isMathOrScience
                    {
                        html += "<script type='text/x-mathjax-config'>"
                        html += "MathJax.Hub.Config({tex2jax: {inlineMath: [['\\\\(','\\\\)']]}});"
                        html += "MathJax.Hub.Queue(function () {"
                        html += "document.getElementById('optionTable').style.visibility='visible';"
                        html += "document.getElementById('descriptionDiv').style.visibility='visible';"
                        html += "document.getElementById('relatedInfoBody').style.visibility='visible';"
                        html += "});"
                        html += "</script>"
                        html += "<script type='text/javascript' "
                        html += "async src='https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-MML-AM_CHTML'>"
                        html += "</script>"
                        html += "<style>*{font-size:13px;color:#4A4A4A;}</style>"
                    }
                    else
                    {
                        html += "<style>*{font-size:13px;line-height:150%;color:#4A4A4A;font-family:'PingFang SC'}img{width:100%}</style>"
                    }
                    
                    html += "<script>"
                    html += "function resetImageSize(){"
                    html += "var div = document.getElementById('descriptionDiv');"
                    html += "var imgs = div.getElementsByTagName('img');"
                    html += "if(imgs && imgs.length > 0){"
                    html += "for(var i=0; i<imgs.length; i++){"
                    html += "var src = imgs[i].getAttribute('src');"
                    html += "if(src != 'iconCheckOff.png' && src != 'iconCheckOn.png'){"
                    html += "imgs[i].style.width='100%';imgs[i].style.height='auto';"
                    html += "}}}}</script>"
                    
                    html += "<body onload='resetImageSize()'>"
                    
                    if let relatedInfo = json["relatedInfo"] as? [String: Any]
                    {
                        let startNumber = relatedInfo["startNumber"] as! Int
                        let endNumber = relatedInfo["endNumber"] as! Int
                        html += "<div style='border:solid #000 1px;font-size:14px;padding:10px;'>";
                        html += "Use the following information to answer questions \(startNumber)-\(endNumber)"
                        html += "</div>"
                        
                        let relatedInfoBody = relatedInfo["body"] as! String
                        if isMathOrScience
                        {
                            html += "<div id='relatedInfoBody' style='background:#eee;visibility:hidden'>\(String(describing: relatedInfoBody))</div>";
                        }
                        else
                        {
                            html += "<div id='relatedInfoBody' style='background:#eee;'>\(String(describing: relatedInfoBody))</div>";
                        }
                    }
                    
                    if description != nil
                    {
                        if isMathOrScience
                        {
                            html += "<div id='descriptionDiv' style='line-height:200%;margin-bottom:10px;visibility:hidden'>\(String(describing: description!))</div>"
                        }
                        else
                        {
                            html += "<div id='descriptionDiv' style='line-height:200%;margin-bottom:10px;'>\(String(describing: description!))</div>"
                        }
                    }
                    
                    if isMathOrScience
                    {
                        html += "<table id='optionTable' width=\"100%\" style=\"margin-bottom:80px;visibility:hidden\">"
                    }
                    else
                    {
                        html += "<table id='optionTable' width=\"100%\" style=\"margin-bottom:80px;\">"
                    }
                    let questionType = json["questionType"] as? String
                    if questionType == "category_table"
                    {
                        //有分组
                        let categories = json["categories"] as! [String]
                        html += "<tr><td style='width:35px;vertical-align:top'></td>"
                        for i in 0...(categories.count)-1
                        {
                            html += "<td align='center'><p style='border-bottom: thin solid #555;margin:0px 10px;'>\(categories[i])</p></td>"
                        }
                        html += "</tr>"
                    }
                    
                    let options = json["options"] as? [[String:Any]]
                    if options != nil && (options?.count)! > 0
                    {
                        let answerCount = options?.count
                        
                        for i in 0...answerCount!-1
                        {
                            var answerValue = false
                            if let value = options?[i]["answer"] as? Bool
                            {
                                answerValue = value
                            }
                            
                            let value = options?[i]["value"]
                            var icon = "iconCheckOff.png"
                            if answerValue == true
                            {
                                icon = "iconCheckOn.png"
                            }
                            html += "<tr><td height=\"30px\" valign=\"top\" style='width:35px;vertical-align:top'>"
                            
                            var marginTop = 3
                            if let valueDemo = value as? String
                            {
                                if valueDemo.components(separatedBy: "<sup>").count > 1
                                {
                                    marginTop = 6
                                }
                            }
                            html += "<div style='width:14px;margin-top:\(marginTop)px;'><img width='14' height='14' src='\(icon)' style='vertical-align:top'/></div></td>"
                            
                            if questionType == "category_table"
                            {
                                let value2 = value as! [String]
                                for i in 0...(value2.count)-1
                                {
                                    html += "<td align='center'>\(String(describing: value2[i]))</td>"
                                }
                            }
                            else
                            {
                                let value2 = value as! String
                                let letter = options?[i]["letter"] ?? ""
                                if value2.components(separatedBy: "<p>").count > 1
                                {
                                    let value2 = value2.replacingOccurrences(of: "<p>", with: "<p>\(letter). ")
                                    html += "<td  valign=\"top\">\(value2)</td></tr>"
                                }
                                else
                                {
                                    html += "<td  valign=\"top\">\(letter). \(value2)</td></tr>"
                                }
                                
                            }
                            
                        }
                    }
                    html += "</table></body></html>"
                    
                    html = html.replacingOccurrences(of: "img src=", with: "img style=\"width:80%;vertical-align:top;\" src=")
                    html = html.replacingOccurrences(of: "/files/inline-images", with: "http://www.coolketang.com/files/inline-images")
                    
                    print(html)
                    self.answerWebView.loadHTMLString(html, baseURL: resourceURL)
                    
                }
        }
    }

    func caculateCellHeight(comment:String)->CGFloat
    {
        let font = self.font14
        let size = comment.boundingRect(with: CGSize(), options: .usesFontLeading, attributes: [NSFontAttributeName:font], context: nil);
        let thisW = self.view.frame.size.width - 40
        let lineNum = ceil(size.width/thisW)
        
        return lineNum * 24
    }
    
    deinit {
        self.answerWebView.removeFromSuperview()
        self.answerWebView = nil
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

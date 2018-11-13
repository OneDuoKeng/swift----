


//
//  WYGuidePageView.swift
//  WYGuidePageView
//
//  Created by 薇谙 on 2018/7/10.
//  Copyright © 2018年 WY. All rights reserved.
//

import UIKit

class WYGuidePageView: UIView {

    private var imageArray: Array<String>?
    var startCompletion: (() -> ())?
    var loginCompletion :(() -> ())?
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public convenience init(frame: CGRect = UIScreen.main.bounds,
                            images: Array<String>,
                            loginRegistCompletion: (() -> ())?,
                            startCompletion: (() -> ())?) {
        self.init(frame: frame)
        self.imageArray = images
        self.startCompletion = startCompletion
        self.loginCompletion = loginRegistCompletion
        
        setupSubviews(frame: frame)
        self.backgroundColor = UIColor.lightGray
        
    }
    
    private func setupSubviews(frame: CGRect){
        let size = UIScreen.main.bounds.size
        guideScrollView.frame = frame
        guideScrollView.contentSize = CGSize.init(width: frame.size.width * CGFloat((imageArray?.count ?? 0)), height: frame.size.height)
        self.addSubview(guideScrollView)
        
        skipButton.frame = CGRect.init(x: size.width - 70.0, y: 40.0, width: 50.0, height: 24.0)
        self.addSubview(skipButton)
        
        guard imageArray != nil,imageArray?.count ?? 0 > 0 else {
            return
        }
        for index in 0..<(imageArray?.count ?? 1) {
            let name = imageArray![index]
            let imageFrame = CGRect.init(x: size.width * CGFloat(index), y: 0.0, width: size.width, height: size.height)
            let filePath = Bundle.main.path(forResource: name, ofType: nil)
            let data: Data? = try? Data.init(contentsOf: URL.init(fileURLWithPath: filePath!), options: Data.ReadingOptions.uncached)
            var view: UIView
            let type = GifImageOperation.checkDataType(data: data)
            if type == DataType.gif{
                view = GifImageOperation.init(frame: imageFrame, gifData: data!)
            }else
            {
                // Warning: 假如说图片是放在Assets中的，使用Bundle的方式加载不到，需要使用init(named:)方法加载。
                view = UIImageView.init(frame: imageFrame)
                view.contentMode = .scaleAspectFill
                (view as! UIImageView).image = (data != nil ? UIImage.init(data: data!) : UIImage.init(named: name))
            }
            
            guideScrollView.addSubview(view)
           
        }
         self.addSubview(pageControl)
        self.addSubview(loginButton)
    }
    
    /// 作为 pod 第三方库取图片资源
    ///
    /// - Parameter name: 图片名
    /// - Returns: 图片
//    private func imageFromBundle(name: String) -> UIImage {
//        let podBundle = Bundle(for: self.classForCoder)
//        let bundleURL = podBundle.url(forResource: "GuideImage", withExtension: "bundle")
//        let bundle = Bundle(url: bundleURL!)
//        let image = UIImage(named: String(name), in: bundle, compatibleWith: nil)
//        return image!
//    }
    
    /// 根据UIColor创建UIImage
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 图片大小
    /// - Returns: 图片
//    private func creatImage(color: UIColor, size: CGSize = CGSize.init(width: 100, height: 100)) -> UIImage {
//        let size = (size == CGSize.zero ? CGSize(width: 100, height: 100): size)
//        UIGraphicsBeginImageContext(size)
//        let context = UIGraphicsGetCurrentContext()
//        context!.setFillColor(color.cgColor)
//        context!.fill(CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image!
//    }

    
    //MARK: private
    @objc private func skipButtonClicked(){
        if self.startCompletion != nil {
            self.startCompletion!()
        }
        self.removeGuideViewFromSupview()
    }
    
    @objc private func loginButtonClick(){
        if self.loginCompletion != nil {
            self.loginCompletion!()
        }
        self.removeGuideViewFromSupview()
    }
    
    private func removeGuideViewFromSupview(){
        UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }) { (_) in
            self.removeFromSuperview()
        }
    }

    
    //MARK: lazy
    private lazy var guideScrollView:UIScrollView = {
        let view = UIScrollView.init()
        view.backgroundColor = UIColor.lightGray
        view.bounces = false
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        return view
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("跳过", for: .normal)
        button.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.sizeToFit()
        button.addTarget(self, action: #selector(skipButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: self.center.x - 60, y: UIScreen.main.bounds.size.height - 120, width: 120, height: 30)
        button.setTitle("登录", for:.normal )
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.white, for: .normal)
        button.isHidden = true
        button.backgroundColor = UIColor.init(red: 0, green: 163, blue: 43, alpha: 1)
        button.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect.init(x: self.center.x - 60, y: UIScreen.main.bounds.size.height - 80, width: 120, height: 20))
        pageControl.numberOfPages = (self.imageArray?.count)!
        pageControl.currentPage = 0
        pageControl.hidesForSinglePage = true
        pageControl.currentPageIndicatorTintColor = UIColor.green
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        return pageControl
    }()
   
}

    //MARK: UIScrollViewDelegate
    extension WYGuidePageView: UIScrollViewDelegate{
        public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let page: Int = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
//            // 设置指示器
            pageControl.currentPage = page
//            // 显示“登录”按钮
            if  (imageArray?.count ?? 0) - 1 == page {
                UIView.animate(withDuration: 1.0, animations: {
                    self.loginButton.isHidden = false
                })
            }else
            {
                UIView.animate(withDuration: 1.0, animations: {
                    self.loginButton.isHidden = true
                })
            }
    }
}


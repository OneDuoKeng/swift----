//
//  SwiftBannerPageControl.swift
//  SwiftBannerView
//
//  Created by LuKane on 2018/5/22.
//  Copyright © 2018年 LuKane. All rights reserved.
//
/**
 * 使用 SwiftBannerView的过程中,有任何bug或问题,都可以在github上提出 issue
 * 或者 联系QQ: 1169604556
 * Github: https://github.com/LuKane
 */
import UIKit

class SwiftBannerPageControl: UIView {
    
    private var pageControl : UIPageControl?
    private var customControl : SwiftBannerCustomPageControl?
    
    public var bannerModel : SwiftBannerModel? {
        didSet {
            if bannerModel?.pageControlImgArr == nil || bannerModel?.pageControlImgArr?.count == 0 { // 系统pageControl
                
                customControl?.isHidden = true
                pageControl?.isHidden = false
                
                pageControl?.currentPage = (bannerModel?.currentPage)!
                pageControl?.numberOfPages = (bannerModel?.numberOfPages)!
                pageControl?.pageIndicatorTintColor = bannerModel?.pageIndicatorTintColor
                pageControl?.currentPageIndicatorTintColor = bannerModel?.currentPageIndicatorTintColor
                
            }else{ // 自定义pageControl
                
                pageControl?.isHidden = true
                customControl?.isHidden = false
                
                if bannerModel?.pageControlImgArr?.count != 2 {
                    bannerModel?.pageControlImgArr = nil
                }else{
                    let isImage = bannerModel?.pageControlImgArr?.firstObject is UIImage
                    let isImage2 = bannerModel?.pageControlImgArr?.lastObject is UIImage
                    
                    if isImage != true || isImage2 != true {
                        bannerModel?.pageControlImgArr = nil
                    }
                }
                
                if customControl?.isHidden == false && bannerModel?.pageControlImgArr != nil {
                    customControl?.imageArr = (bannerModel?.pageControlImgArr)!
                    customControl?.numberOfPage = (bannerModel?.numberOfPages)!
                }
            }
            layoutSubviews()
        }
    }
    
    public var currentPage : Int = 0 {
        didSet {
            if pageControl?.isHidden == false {
                pageControl?.currentPage = currentPage
            }else if bannerModel?.pageControlImgArr != nil && bannerModel?.pageControlImgArr?.count != 0 {
                customControl?.currentPage = currentPage
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPageControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPageControl(){
        let pageControl = UIPageControl.init(frame: self.bounds)
        self.pageControl = pageControl
        addSubview(pageControl)
        
        let customControl = SwiftBannerCustomPageControl.init(frame: self.bounds)
        self.customControl = customControl
        addSubview(customControl)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch bannerModel?.pageControlStyle {
            case .left?:
                let x1 : CGFloat = 10 - self.width / 2
                let x2 : CGFloat = CGFloat((bannerModel?.numberOfPages)! * 5)
                let x3 : CGFloat = CGFloat(((bannerModel?.numberOfPages)! - 1) / 2 * 5)
                pageControl?.frame = CGRect(x: x1 + x2 + x3, y: 0, width: self.width, height: 30)
                break
            case .right?:
                let x1 : CGFloat = self.width * 0.5
                let x2 : CGFloat = CGFloat((bannerModel?.numberOfPages)! * 10)
                let x3 : CGFloat = CGFloat(((bannerModel?.numberOfPages)! - 1) * 5)
                let x4 : CGFloat = x1 - (x2 + x3) / 2 - 10
                pageControl?.frame = CGRect(x: x4, y: 0, width: self.width, height: 30)
                break
            case .middle?:
                pageControl?.frame = CGRect(x: 0, y: 0, width: self.width, height: 30)
                break
            default:
                break
        }
        
        if bannerModel?.pageControlImgArr != nil && bannerModel?.pageControlImgArr?.count != 0 {
            
            let image = bannerModel?.pageControlImgArr?.firstObject as! UIImage
            let width = CGFloat((bannerModel?.numberOfPages)!) * (image.size.width + 5)
            
            switch bannerModel?.pageControlStyle {
                case .left?:
                    customControl?.frame = CGRect(x: 5, y: 0, width: width, height: 30)
                    break
                case .middle?:
                    customControl?.frame = CGRect(x: (self.width - width) / 2, y: 0, width: width, height: 30)
                    break
                case .right?:
                    customControl?.frame = CGRect(x: self.width - width - 5, y: 0, width: width, height: 30)
                    break
                default:
                    break
            }
        }
    }
}

private class SwiftBannerCustomPageControl : UIView {

    private lazy var layerArr : NSMutableArray = { () -> NSMutableArray in
        let layerArr : NSMutableArray = NSMutableArray()
        return layerArr
    }()
    
    private var selectIndex : Int?
    
    private var selectImg : UIImage?
    private var unselectImg : UIImage?
    
    public var imageArr : NSArray = [] {
        didSet {
            self.selectImg = imageArr.firstObject as? UIImage
            self.unselectImg = imageArr.lastObject as? UIImage
        }
    }
    
    public var currentPage : Int = 0 {
        didSet {
            if self.layerArr.count == 0 {
                return;
            }
            
            let layer = self.layerArr[self.selectIndex!] as! CALayer
            layer.contents = self.unselectImg?.cgImage
            
            let layer1 = self.layerArr[currentPage] as! CALayer
            layer1.contents = self.selectImg?.cgImage
            
            self.selectIndex = currentPage
            
//                if(self.layerArr.count == 0) return;
//
//                CALayer *layer = _layerArr[_selectIndex];
//                [layer setContents:(__bridge id _Nullable)_unSelectImg.CGImage];
//
//                CALayer *layer1 = _layerArr[currentPage];
//                [layer1 setContents:(__bridge id _Nullable)_selectImg.CGImage];
//                _selectIndex = currentPage;
            
//            for i in 0..<layerArr.count {
//                let layer = layerArr[i] as! CALayer
//                layer.contents = self.unselectImg?.cgImage
//                if currentPage == i {
//                    if self.selectImg != nil {
//                        layer.contents = self.selectImg?.cgImage
//                    }
//                }
//            }
        }
    }
    
    public var numberOfPage : Int = 0 {
        didSet {
            if numberOfPage == 0 {
                return
            }
            if layerArr.count != 0 {
                for layer in layerArr {
                    (layer as! CALayer).removeFromSuperlayer()
                }
                layerArr.removeAllObjects()
            }
            for _ in 0..<numberOfPage{
                let layer = CALayer.init()
                layer.contents = self.unselectImg?.cgImage
                self.layer.addSublayer(layer)
                layerArr.add(layer)
            }
            
            let layer : CALayer = layerArr.firstObject as! CALayer
            layer.contents = self.selectImg?.cgImage
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.selectIndex = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if layerArr.count == 0 {
            return
        }
        
        if imageArr.count != 2{
            return
        }
        
        let padding : CGFloat = 5
        let width : CGFloat = (self.selectImg?.size.width)!
        let height : CGFloat = (self.selectImg?.size.height)!
        
        for i in 0..<layerArr.count {
            let x = CGFloat(i) * (width + padding) + padding
            let y = (30 - height) / 2
            let layer = layerArr[i] as! CALayer
            layer.frame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
}

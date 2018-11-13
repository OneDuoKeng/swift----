//
//  ViewController.swift
//  swift--UIImageView实例
//
//  Created by 研发ios工程师 on 2018/11/8.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView3:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
        
        //MARK:1 手动创建图片
        let imageView = UIImageView(image: UIImage(named: "SGQR1"), highlightedImage: UIImage(named: "SGQR2"))
        imageView.frame = CGRect(x: 100, y: 200, width: 100, height: 100)
        self.view.addSubview(imageView)
        
        //-------保持图片比例
        //默认 UIImageView 会拉伸图片使其占满整个 UIImageView，如果不想让图片变形，可以将 ContentMode 设置为 Aspect Fit。
        imageView.contentMode = .scaleAspectFit
        
        //设置图片image
        //imageView.image = UIImage(named:"icon2")
        //MARK: 2  -------从文件目录中获取图片
        let path = Bundle.main.path(forResource: "gas_virtual_sense", ofType: "png")
        let newImage = UIImage(contentsOfFile: path!)
        let imageView1 = UIImageView(image:newImage)
        
        imageView1.frame = CGRect(x: 200, y: 400, width: 100, height: 100)
        self.view.addSubview(imageView1)
        
//        //MARK: 3 ------从网络地址获取图片
//        //定义URL对象
//        let url = URL(string: "http://******/l.png")
//        //从网络获取数据流
//        let data = try! Data(contentsOf: url!)
//
//        //通过数据流初始化图片
//        let newImage1 = UIImage(data: data)
//        let imageView2 = UIImageView(image:newImage1);
//        imageView2.frame = CGRect(x: 300, y: 400, width: 100, height: 100)
//        self.view.addSubview(imageView2)
        
        //MARK: 4  动画图片
        imageView3 = UIImageView()
        imageView3.frame = CGRect(x:20, y:20, width:100, height:100)
        //设置动画图片
        imageView3.animationImages = [UIImage(named:"SGQR1")!,UIImage(named:"SGQR2")!]
        //设置每隔0.5秒变化一次
        imageView3.animationDuration = 0.5
        self.view.addSubview(imageView3)
        
        //MARK: 5 ---网络加载图片
        let image1 = UIImageView()
        image1.downloadedFrom(imageurl: "https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=2db36eed022442a7b10efba5e142ad95/4d086e061d950a7bb1ea1aaa07d162d9f3d3c985.jpg")
        image1.contentMode = .scaleAspectFit
        image1.frame = CGRect(x: 200, y: 200, width: 200, height: 200)
        self.view.addSubview(image1)
        
        // MARK: 6 ---图片缩放
        //        通过图形的上下文，实现图形的缩放
        //        读取一张图片
        let image6 = UIImage(named: "SGQR1")
        //        调用图像缩小的方法
        let scaledImage = scaleImage(image: image6!, newSize: CGSize(width: 180, height: 180))
        //        创建一个一个图像视图，并加载缩小后的图片
        let imageView6 = UIImageView(image: scaledImage)
        //        设置图像视图的中心点
        imageView6.center = CGPoint(x: 260, y: 360)
        
        self.view.addSubview(imageView6)
        
        // MARK: 7 ---图片切圆角
        let image7 = UIImage(named: "speech_bg_normal")?.toCircle()
        //创建imageView
        let imageView7 = UIImageView(image: image7)
        imageView7.frame = CGRect(x:40, y:400, width:100, height:100)
        self.view.addSubview(imageView7)
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        imageView3.startAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        imageView3.stopAnimating()
    }
    
    //MARK: ---------- UIImage转Data
    // 只有当uiImage.cgImage有值的时候才可以使用UIImagePNGRepresentation(_ image: UIImage)
    // 或者UIImageJPEGRepresentation(_ image: UIImage, _ compressionQuality: CGFloat)转换为Data
    func convertUIImageToData(uiImage:UIImage) -> Data {
        
        var data = uiImage.pngData()
        
        if data == nil {
            let cgImage = self.convertUIImageToData(uiImage: uiImage)
            let uiImage = UIImage.init(cgImage: cgImage as! CGImage)
            data = uiImage.pngData()
        }
        return data!
    }
    
    //创建一个方法，传递一个图像参数和缩放比例参数，实现缩放功能
    func scaleImage(image:UIImage , newSize:CGSize)->UIImage{
        //        获得原图像的尺寸属性
        let imageSize = image.size
        //        获得原图像的宽度数值
        let width = imageSize.width
        //        获得原图像的高度数值
        let height = imageSize.height
        
        //        计算图像新尺寸与旧尺寸的宽高比例
        let widthFactor = newSize.width/width
        let heightFactor = newSize.height/height
        //        获取最小的比例
        let scalerFactor = (widthFactor < heightFactor) ? widthFactor : heightFactor
        
        //        计算图像新的高度和宽度，并构成标准的CGSize对象
        let scaledWidth = width * scalerFactor
        let scaledHeight = height * scalerFactor
        let targetSize = CGSize(width: scaledWidth, height: scaledHeight)
        
        //        创建绘图上下文环境，
        UIGraphicsBeginImageContext(targetSize)
        image.draw(in: CGRect(x: 0, y: 0, width: scaledWidth, height: scaledHeight))
        //        获取上下文里的内容，将视图写入到新的图像对象
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return newImage!
    }
}


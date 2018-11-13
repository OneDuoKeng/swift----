//
//  ViewController.swift
//  swift--UIScrollView实例
//
//  Created by 研发ios工程师 on 2018/11/8.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIScrollViewDelegate {

    let scrollView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: 创建scrollview
        scrollView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 300)
        scrollView.backgroundColor = UIColor.lightGray
        self.view.addSubview(scrollView)
        
        //设置滚动条
        //是否显示水平滚动条
        scrollView.showsHorizontalScrollIndicator = true
        //是否显示竖直滚动条
        scrollView.showsVerticalScrollIndicator = false
        
        //设置分页滚动
        scrollView.isPagingEnabled = true
        
        //设置是否可以拉出空白区域
        scrollView.bounces = true
        
        //默认是false。如果是true并且bounces也是true,即使内容尺寸比scrollView的尺寸小,也能垂直推动
        scrollView.alwaysBounceVertical  = false
        
        //默认是false。如果是true并且bounces也是true,即使内容尺寸比scrollView的尺寸小,也能水平推动
        scrollView.alwaysBounceHorizontal = false
        
        //允许滑动视图本身,如果设为false就不能触发拖动代理事件
//        scrollView.isScrollEnabled = false
        
        //在scrollView的内容周围添加一个附件的区域
        scrollView.contentInset = UIEdgeInsets(top: 100,left: 50, bottom: 50,right: 50)
        
        //调整指示器(滚动条)的位置
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 30,left: 30, bottom: 30,right: 30)
        
        //设置指示器(滚动条)的样式
        scrollView.indicatorStyle = UIScrollView.IndicatorStyle.black//黑色
        
        //最小的缩放倍数,默认值为1.0
        scrollView.minimumZoomScale = 0.2
        
        //放大的缩放倍数,默认值为1.0
        scrollView.maximumZoomScale = 10
        
        //创建一个数组,存储三张图片
        let imagesArray = ["1con","2con","3con"]
        let ww = scrollView.frame.size.width/3
        let hh = scrollView.frame.size.width/3
        
        //循环创建ImageView
        for i in 0..<imagesArray.count {
            
            //创建imageView
            let imageView = UIImageView()
            imageView.frame = CGRect(x: ww * CGFloat(i), y: 0, width: ww, height: hh)
            //添加图片
            imageView.image=UIImage(named: imagesArray[i])
            //打开用户交互
            imageView.isUserInteractionEnabled = true
            //把imageView添加到滚动视图上
            scrollView.addSubview(imageView)
        }
        
        //设置内容区域
        scrollView.contentSize = CGSize(width: ww*CGFloat(imagesArray.count), height: hh)
        //设置代理
        scrollView.delegate = self
        
        //设置directionalLockEnabled
        /*
         
         如果这个性能被设置成false,scrollView会被允许在水平和垂直两个方向滚动。如果设置性能是true并且用户开始在一个方向拖动时(水平方向或垂直方向),滚动视图就不能在另一个方向滚动。如果拖动的方向时斜对角线方向,拖动事件将会被锁住并且用户可以在任何方向拖动,直到拖动事件结束。这个属性的默认值是false。
         */
//        scrollView.isDirectionalLockEnabled = true
        
        //设置偏移量,以固定的速度设置成新的偏移量
        scrollView.setContentOffset(CGPoint(x: 10, y: 20), animated: false)
        
        //滚动矩形区域到可见的区域,如果完全可见就不做任何操作
        scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 100, height: 300), animated: false)
        
        //默认值为true
//        scrollView.delaysContentTouches =true
        
        //默认值为true。如果为false,一旦我们开始追踪并且触摸移动,我们无法拖动
//        scrollView.canCancelContentTouches =true
        
        //默认为true。如果设置,当手势起作用时用户会经过最小/最大的区域,并且,在手势结束时这个区域会自动设置为最小/最大值。
        scrollView.bouncesZoom = true
        
        // 当用户向上的手势时,会返回true readonly
        //scrollView.isZooming
        //当我们在最小和最大值中间的一个区域中,会返回true。
        //scrollView.zoomBouncing
        //使用这些容器配置scrollView内置的手势识别
        //scrollView.panGestureRecognizer
        //scrollView.pinchGestureRecognizer
        //滚动到顶部,默认值为true
        scrollView.scrollsToTop = true
        
        // MARK: 创建UIPageControl
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: hh-30, width: 200, height: 30))
        
        //总的图片页数
        pageControl.numberOfPages = 6
        
        //当前页
        pageControl.currentPage = 0
        
        //用户点击UIPageControl的响应函数
        pageControl.addTarget(self, action:#selector(pageTurn(pageControl:)), for:UIControl.Event.valueChanged)
        
        //设置pageControl的尺寸
        _ = pageControl.size(forNumberOfPages: 6)
        
        self.view.addSubview(pageControl)
    }
    
    //点点的点击事件
    @objc func pageTurn(pageControl:UIPageControl) {
        
       print("点点")
    }
    
    //UIscrollView的协议代理方法
    //滑动过程中
    func scrollViewDidScroll(_ scrollView:UIScrollView) {
        
    }
    //开始拖动
    func scrollViewWillBeginDragging(_ scrollView:UIScrollView) {
        
        
    }
    //开始拖动(以某种速率和偏移量)
    func scrollViewDidEndDecelerating(_ scrollView:UIScrollView) {
        
    }
    
    //停止拖动
    func scrollViewDidEndDragging(_ scrollView:UIScrollView, willDecelerate decelerate:Bool) {
        
    }
    //开始滑动
    func scrollViewWillBeginDecelerating(_ scrollView:UIScrollView) {
        
    }
    
    //允许缩放的视图(一个scrollview中只能有一个可以缩放且必须设置可以缩放的范围)
    //    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    //
    //        //返回被缩放的试图
    //        //return imageView;
    //    }
    
    //开始缩放的时候调用
    func scrollViewWillBeginZooming(_ scrollView:UIScrollView, with view:UIView?) {
        
    }
    
    //正在缩放的时候调用
    func scrollViewDidZoom(_ scrollView:UIScrollView) {
        
    }
    
    //缩放完毕的时候调用
    func scrollViewDidEndZooming(_ scrollView:UIScrollView, with view:UIView?, atScale scale: CGFloat) {
        
    }
    
    //将要滚动到顶部的时候调用
    func scrollViewShouldScrollToTop(_ scrollView:UIScrollView) -> Bool {
        
        return true
    }
    
    //滚动到顶部的时候调用
    func scrollViewDidScrollToTop(_ scrollView:UIScrollView) {
        
    }
}


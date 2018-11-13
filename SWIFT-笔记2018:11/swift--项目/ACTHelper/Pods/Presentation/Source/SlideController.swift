import UIKit

open class SlideController: UIViewController {
    
    fileprivate var contents = [Content]()
    fileprivate var animations = [Animatable]()
    fileprivate var visible = false
    fileprivate var isLastPage = false
    fileprivate var isPreLastPage = false
    var emitterLa :CAEmitterLayer = CAEmitterLayer()
    
    public convenience init(contents: [Content]) {
        self.init()
        
        add(contents: contents)
    }
    
    // MARK: - View lifecycle
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !visible
        {
            visible = true
            for content in contents
            {
                content.layout()
            }
            
            for animation in animations
            {
                animation.play()
            }
        }
        
        if isPreLastPage
        {
            if(emitterLa.birthRate > 1.0)
            {
                emitterLa.isHidden = false
            }
            else
            {
                playYanHua()
            }
        }
        if isLastPage
        {
            let notificationName = Notification.Name(rawValue: "gotoIndexPage")
            NotificationCenter.default.post(name: notificationName, object: self.parent,
                                            userInfo: ["value1":"test", "value2" : 12345])
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        visible = false
        
        emitterLa.removeFromSuperlayer()
        
    }
    
    // MARK: - Navigation
    
    open func goToLeft() {
        for case let animation as TransitionAnimation in animations {
            animation.reflective = true
        }
    }
    
    open func goToRight() {
        for case let animation as TransitionAnimation in animations {
            animation.reflective = false
        }
    }
}

// MARK: - Public methods

extension SlideController {
    
    public func add(contents: [Content]) {
        for content in contents {
            add(content: content)
        }
    }
    
    public func add(content: Content) {
        contents.append(content)
        view.addSubview(content.view)
        
        content.layout()
    }
    
    public func add(animations: [Animatable]) {
        for animation in animations {
            add(animation: animation)
        }
    }
    
    public func add(animation: Animatable) {
        animations.append(animation)
    }
    
    public func setLast() {
        isLastPage = true
    }
    
    public func setPreLast() {
        isPreLastPage = true
    }
    
    public func playYanHua()
    {
        //加载颗粒状的火花图片
        emitterLa = CAEmitterLayer();
        emitterLa.emitterPosition = CGPoint(x:self.view.bounds.size.width/2, y:self.view.bounds.size.height*0.75);
        emitterLa.renderMode = kCAEmitterLayerAdditive;
        emitterLa.emitterSize = CGSize(width: 200, height: 200)
        
        //爆炸前逐渐隐藏发射颗粒
        let emitterCeRocket = CAEmitterCell();
        emitterCeRocket.emissionLongitude = CGFloat(-M_PI_2);
        emitterCeRocket.emissionLatitude = 0;
        emitterCeRocket.lifetime = 1.6;
        emitterCeRocket.birthRate = 1;
        emitterCeRocket.velocity = 400;
        emitterCeRocket.velocityRange = 100;
        emitterCeRocket.yAcceleration = 250;
        emitterCeRocket.emissionRange = CGFloat(M_PI/4);
        emitterCeRocket.color = UIColor(red: 0.9, green:0.9, blue:0.9, alpha:0.8).cgColor.copy();
        emitterCeRocket.redRange = 0.5;
        emitterCeRocket.greenRange = 0.5;
        emitterCeRocket.blueRange = 0.5;
        //设置动画效果的路径名称
        emitterCeRocket.name = "rocket";
        
        //添加路径状态
        let emitterCeFly = CAEmitterCell();
        emitterCeFly.contents = UIImage(named: "tspark.png")!.cgImage;
        emitterCeFly.emissionLongitude = CGFloat((4*M_PI)/2);
        emitterCeFly.scale = 0.4;
        emitterCeFly.velocity = 100;
        emitterCeFly.birthRate = 45;
        emitterCeFly.lifetime = 1.5;
        emitterCeFly.yAcceleration = 350;
        emitterCeFly.emissionRange = CGFloat(M_PI/7);
        emitterCeFly.alphaSpeed = -0.7;
        emitterCeFly.scaleSpeed = -0.1;
        emitterCeFly.scaleRange = 0.1;
        emitterCeFly.beginTime = 0.01;
        emitterCeFly.duration = 0.7;
        
        //设置爆炸
        let emitterCeFirework = CAEmitterCell();
        emitterCeFirework.contents = UIImage(named: "tspark.png")!.cgImage;
        emitterCeFirework.birthRate = 9999;
        emitterCeFirework.scale = 0.6;
        emitterCeFirework.velocity = 130;
        emitterCeFirework.lifetime = 2;
        emitterCeFirework.alphaSpeed = -0.2;
        emitterCeFirework.yAcceleration = 80;
        emitterCeFirework.beginTime = 1.5;
        emitterCeFirework.duration = 0.1;
        emitterCeFirework.emissionRange = CGFloat(2*M_PI);
        emitterCeFirework.scaleSpeed = -0.1;
        emitterCeFirework.spin = 2;
        //设置爆炸动画名称
        emitterCeFirework.name = "firework";
        
        //添加重复过程
        let emitterCePreSpark = CAEmitterCell();
        emitterCePreSpark.birthRate = 80;
        emitterCePreSpark.velocity = emitterCeFirework.velocity*0.7;
        emitterCePreSpark.lifetime = 1.7;
        emitterCePreSpark.yAcceleration = emitterCeFirework.yAcceleration*0.85;
        emitterCePreSpark.beginTime = emitterCeFirework.beginTime-0.2;
        emitterCePreSpark.emissionRange = emitterCeFirework.emissionRange;
        emitterCePreSpark.greenSpeed = 100;
        emitterCePreSpark.blueSpeed = 100;
        emitterCePreSpark.redSpeed = 100;
        //设置重复动画名称
        emitterCePreSpark.name = "preSpark";
        
        //烟花最后的闪光
        let emitterCeSparkle = CAEmitterCell();
        emitterCeSparkle.contents = UIImage(named: "tspark.png")!.cgImage;
        emitterCeSparkle.lifetime = 0.05;
        emitterCeSparkle.yAcceleration = 250;
        emitterCeSparkle.beginTime = 0.8;
        emitterCeSparkle.scale = 0.4;
        emitterCeSparkle.birthRate = 10;
        
        emitterCePreSpark.emitterCells = NSArray.init(objects:emitterCeSparkle) as? [CAEmitterCell];
        emitterCeRocket.emitterCells = NSArray.init(objects:emitterCeFly,emitterCeFirework,emitterCePreSpark) as? [CAEmitterCell];
        emitterLa.emitterCells = NSArray.init(objects: emitterCeRocket) as? [CAEmitterCell];
        self.view.layer.addSublayer(emitterLa)
    }
    
}

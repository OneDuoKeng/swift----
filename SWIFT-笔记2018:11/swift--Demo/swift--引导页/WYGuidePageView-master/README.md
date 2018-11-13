# WYGuidePageView

      let imageGifArray = ["guideImage5.jpg","adImage4.gif","guideImage7.gif","guideImage3.jpg", "shopping.gif"]
       
       let guideView = WYGuidePageView.init(images: imageGifArray, loginRegistCompletion: {
            print("登录/注册")
        }) {
            print("开始使用app")
        }
        
        self.view.addSubview(guideView)
![image] https://github.com/jieyiyou/WYGuidePageView/blob/master/Screen%20.png

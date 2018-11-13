//
//  AppDelegate.swift
//  DemoApp
//
//  Created by LiFazhan on 17/1/20.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()

        if(DataUtil.hasShowIntro())
        {
            //曾经显示过intro页
            if(DataUtil.hasLogined())
            {
                //曾经登陆过
                let vc = ControllerUtil.getTabController()
                window?.rootViewController = vc
            }
            else
            {
                //从未登陆过
                
//                let vc = RegStep7Controller()
//                vc.userInfo = UserInfo()
//                vc.userInfo.myKeMu = .SAT
//                let navigationController = UINavigationController(rootViewController: vc)
//                window?.rootViewController = navigationController
                
                let storyBoard = UIStoryboard(name: "RegLogin", bundle: nil)
                let vc = storyBoard.instantiateInitialViewController()
                let navigationController = UINavigationController(rootViewController: vc!)
                window?.rootViewController = navigationController
            }
        }
        else
        {
            //进入intro页
            let vc = ViewController(pages: [])
            let navigationController = UINavigationController(rootViewController: vc)
            window?.rootViewController = navigationController
        }
        
        window?.makeKeyAndVisible()
        
        
        
        /**
         *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
         *  在将生成的AppKey传入到此方法中。
         *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
         *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
         *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
         */
        
        ShareSDK.registerApp("1db7f78a841a4", activePlatforms:[
            SSDKPlatformType.typeSinaWeibo.rawValue,
            SSDKPlatformType.typeWechat.rawValue,
            SSDKPlatformType.typeMail.rawValue,
            SSDKPlatformType.typeSMS.rawValue,
            SSDKPlatformType.typeQQ.rawValue],
                             onImport: { (platform : SSDKPlatformType) in
                                switch platform
                                {
                                case SSDKPlatformType.typeSinaWeibo:
                                    ShareSDKConnector.connectWeibo(WeiboSDK.classForCoder())
                                case SSDKPlatformType.typeWechat:
                                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                                case SSDKPlatformType.typeQQ:
                                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                                default:
                                    break
                                }
                                
        }) { (platform : SSDKPlatformType, appInfo : NSMutableDictionary?) in
            
            switch platform
            {
            case SSDKPlatformType.typeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                appInfo?.ssdkSetupSinaWeibo(byAppKey: "3112623439",
                                            appSecret : "4c69a099cda6104d3f9edac95ea2cc1a",
                                            redirectUri : "http://www.sharesdk.cn",
                                            authType : SSDKAuthTypeBoth)
                
            case SSDKPlatformType.typeWechat:
                //设置微信应用信息
                appInfo?.ssdkSetupWeChat(byAppId: "wxc82577f08316d1b8", appSecret: "c6ea4756136f81c5fb8ceabebeea9fc1")
                
            case SSDKPlatformType.typeQQ:
                //设置QQ应用信息
                appInfo?.ssdkSetupQQ(byAppId: "1106079593",
                                     appKey : "tjawfv7ipd2inTcV",
                                     authType : SSDKAuthTypeWeb)
            default:
                break
            }
            
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

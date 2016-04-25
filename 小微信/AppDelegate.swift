//
//  AppDelegate.swift
//  小微信
//
//  Created by 赖霄冰 on 16/4/21.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RCIMUserInfoDataSource {

    var window: UIWindow?
    
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        
        let userInfo = RCUserInfo()
        userInfo.userId = userId
        
        switch userId {
        case "laixiaobing":
            userInfo.name = "Larry"
            userInfo.portraitUri = "http://img4.duitang.com/uploads/item/201507/08/20150708234427_vxAUX.png"
        case "laixiaobing2":
            userInfo.name = "赖霄冰的克隆"
            userInfo.portraitUri = "http://www.poluoluo.com/qq/UploadFiles_7828/201604/2016042018290939.jpg"
        default:
            print("No way here")
        }
        return completion(userInfo)
    }
    

    func connectServer(completion:() -> Void) {
        //查询保存的Token
        let tokenCache = NSUserDefaults.standardUserDefaults().objectForKey("kDeviceToken") as? String
        
        //初始化appkey
        RCIM.sharedRCIM().initWithAppKey("p5tvi9dstgry4")
        
        //用token测试连接
        RCIM.sharedRCIM().connectWithToken("M6nnfwPPo4eu9dN83KWycDkXzcOqwmiQHBKZ0O5imqsE0YudPmGYvGCEQr5z1eH6WW057EBZXm6Y8WoXZlrhEcOZqMT4bjzH", success: { (_) in
            let currentUserInfo = RCUserInfo(userId: "laixiaobing2", name: "赖霄冰克隆", portrait: "u=1596959595,73131885&fm=21&gp=0.jpg")
            print("连接成功1")
            
            dispatch_async(dispatch_get_main_queue()) {
                completion()
            }
            
            RCIMClient.sharedRCIMClient().currentUserInfo = currentUserInfo
            }, error: { (_) in
                print("连接失败！")
        }) {
            print("Token不正确，或失效！")
        }
        
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //将用户信息提供者设置为自己的AppDelegate
        RCIM.sharedRCIM().userInfoDataSource = self
        AVOSCloud.setApplicationId("S8IggJCxymrFGBHJ2imUqyP9-gzGzoHsz", clientKey: "1llitKtLP8AqiRjNhRmm23TX")

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


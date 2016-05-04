//
//  MyTabbarController.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/4.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class MyTabbarController: UITabBarController {
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return nil
    }
}

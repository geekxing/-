//
//  Functions.swift
//  小微信
//
//  Created by 赖霄冰 on 16/4/25.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import Foundation
import Dispatch

func afterDelay(seconds: Double, closure:() -> ()) {
    let when = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    
    dispatch_after(when, dispatch_get_main_queue(), closure)
}

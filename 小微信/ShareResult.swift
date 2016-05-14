//
//  ShareResult.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/14.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import Foundation

class ShareResult {
    var imageName = ""
    var descripText = ""
    var price = ""
    
    class func fillResults() -> ShareResult {
        let shareResult = ShareResult()
        shareResult.imageName = "gd"
        shareResult.descripText = "喜之郎什锦果肉果冻布丁三个装"
        shareResult.price = "6.00"
        return shareResult
    }
}

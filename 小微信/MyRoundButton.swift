//
//  MyRoundButton.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/14.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

@IBDesignable
class MyRoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }

}

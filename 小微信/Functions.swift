//
//  Functions.swift
//  小微信
//
//  Created by 赖霄冰 on 16/4/25.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import Foundation
import Dispatch
import UIKit

func afterDelay(seconds: Double, closure:() -> ()) {
    let when = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    
    dispatch_after(when, dispatch_get_main_queue(), closure)
}

func configureButtonWithImageName(imageName: String?, andFrame frame: CGRect) -> UIButton {
    let headButton = UIButton(type: .Custom)
    headButton.frame = frame
    if let headerImageName = imageName {
        headButton.setImage(UIImage(named: headerImageName), forState: .Normal)
    }
    headButton.imageView?.layer.cornerRadius = frame.size.width / 2
    headButton.imageView?.layer.borderWidth = 1
    headButton.imageView?.layer.borderColor = UIColor.whiteColor().CGColor
    headButton.imageView?.contentMode = .ScaleAspectFit
    return headButton
}

func configureLabelWithText(text: String?, andFrame frame : CGRect) -> UILabel {
    let label = UILabel()
    label.frame = frame
    label.font = UIFont.boldSystemFontOfSize(20.0)
    label.textColor = UIColor.whiteColor()
    label.shadowColor = UIColor(white: 0.3, alpha: 0.5)
    label.shadowOffset = CGSizeMake(0, 1)
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.7
    label.numberOfLines = 1
    if let nameLabelText = text {
        label.text = nameLabelText
    }
    return label
}
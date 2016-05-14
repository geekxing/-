//
//  UIEditableLabel.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/6.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

//import UIKit
//
//class UIEditableLabel: UILabel {
//
//    override func becomeFirstResponder() -> Bool {
//        return true
//    }
//    
//    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
//        return (action == #selector(copyText))
//    }
//    
//    override func awakeFromNib() {
//        <#code#>
//    }
//    
//    func copyText(sender: AnyObject?) {
//        let pBoard =  UIPasteboard.generalPasteboard()
//        pBoard.string = self.text
//    }
//    
//    func attatchLongPressHandler() {
//        let touch = UILongPressGestureRecognizer(target: self, action: #selector(handlePress))
//        self.addGestureRecognizer(touch)
//    }
//    
//    
//
//}

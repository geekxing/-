//
//  LoginViewController.swift
//  小微信
//
//  Created by 赖霄冰 on 16/4/23.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginStackView: UIStackView!
    
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1) {
            self.loginStackView.axis = UILayoutConstraintAxis.Vertical
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//extension UIView {
//    @IBInspectable var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = (newValue > 0)
//        }
//    }
//}

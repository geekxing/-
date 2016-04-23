//
//  LoginViewController.swift
//  小微信
//
//  Created by 赖霄冰 on 16/4/23.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, JSAnimatedImagesViewDataSource {
    
    
    @IBOutlet weak var loginStackView: UIStackView!
    
    @IBOutlet weak var wallPaperView: JSAnimatedImagesView!
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1) {
            self.loginStackView.axis = UILayoutConstraintAxis.Vertical
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wallPaperView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - JSAnimatedImagesView DataSource
    func animatedImagesNumberOfImages(animatedImagesView: JSAnimatedImagesView!) -> UInt {
        return 3
    }
    
    func animatedImagesView(animatedImagesView: JSAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        return UIImage(named: "image\(index + 1)")
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

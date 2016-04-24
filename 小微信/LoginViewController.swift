//
//  LoginViewController.swift
//  小微信
//
//  Created by 赖霄冰 on 16/4/23.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, RCAnimatedImagesViewDelegate {
    
    
    @IBOutlet weak var loginStackView: UIStackView!
    
    @IBOutlet weak var wallPaperView: RCAnimatedImagesView!
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1) {
            self.loginStackView.axis = UILayoutConstraintAxis.Vertical
        }
        navigationController?.navigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wallPaperView.delegate = self
        navigationController?.navigationBarHidden = true
        self.wallPaperView.startAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - JSAnimatedImagesView DataSource
    func animatedImagesNumberOfImages(animatedImagesView: RCAnimatedImagesView!) -> UInt {
        return 3
    }
    
    func animatedImagesView(animatedImagesView: RCAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
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

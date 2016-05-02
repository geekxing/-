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
    
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var wallPaperView: RCAnimatedImagesView!
    
    @IBAction func login(sender: UIButton) {
        checkLogin()
    }
    
    //登录校验
    func checkLogin() {
        let userQuery = AVQuery(className: "XBUser")
        userQuery.whereKey("user", equalTo: user.text)
        
        let passQuery = AVQuery(className: "XBUser")
        passQuery.whereKey("pass", equalTo: pass.text)
        
        let query = AVQuery.andQueryWithSubqueries([userQuery, passQuery])
        query.getFirstObjectInBackgroundWithBlock { (result, error) in
            if (result != nil) {
                self.pleaseWait()
                
                self.performSegueWithIdentifier("didLogin", sender: nil)
                self.clearAllNotice()
            } else  if (error.code == 101){
                self.pleaseWait()
                let alert = UIAlertController(title: "用户名/密码错误！", message: nil, preferredStyle: .Alert)
                let action = UIAlertAction(title: "确定", style: .Default, handler:nil)
                alert.addAction(action)
                self.clearAllNotice()
                self.presentViewController(alert, animated: true, completion: nil)
                print(error)
            } else {
                self.pleaseWait()
                let alert = UIAlertController(title: "网络连接错误！", message: nil, preferredStyle: .Alert)
                let action = UIAlertAction(title: "确定", style: .Default, handler: { (_) in
                    self.user.becomeFirstResponder()
                })
                alert.addAction(action)
                self.clearAllNotice()
                self.presentViewController(alert, animated: true, completion: nil)
                print(error)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1) {
            self.loginStackView.axis = UILayoutConstraintAxis.Vertical
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wallPaperView.delegate = self
        navigationController?.navigationBarHidden = true
        self.wallPaperView.startAnimating()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gestureRecognizer
    }
    
    func hideKeyboard(gestureRecognizer: UITapGestureRecognizer) {
        let point = gestureRecognizer.locationInView(self.view)
        user.resignFirstResponder()
        pass.resignFirstResponder()
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

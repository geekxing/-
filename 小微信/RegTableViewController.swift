//
//  RegTableViewController.swift
//  小微信
//
//  Created by 赖霄冰 on 16/4/24.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class RegTableViewController: UITableViewController {
    
    var (userOK, passOK, mailOK) = (false, false, false)

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet var requiredOptions: [UITextField]!
    @IBOutlet weak var user: UITextBox!
    @IBOutlet weak var pass: UITextBox!
    @IBOutlet weak var mail: UITextBox!
    @IBOutlet weak var mobile: UITextBox!
    @IBOutlet weak var ques: UITextBox!
    @IBOutlet weak var answer: UITextBox!
    
    @IBAction func done(sender: AnyObject) {
        self.view.userInteractionEnabled = false
        checkRegister()
    }
    
    func checkRegister() {
        self.pleaseWait()
        //建立对象
        let regdata = AVObject(className: "XBUser")
        //插入数据
        regdata.setObject(user.text, forKey: "user")
        regdata.setObject(pass.text, forKey: "pass")
        regdata.setObject(mail.text, forKey: "mail")
        regdata.setObject(mobile.text, forKey: "mobile")
        regdata.setObject(ques.text, forKey: "question")
        regdata.setObject(answer.text, forKey: "answer")
        regdata.setObject("", forKey: "token")
        //查询用户名是否已被注册
        let query = AVQuery(className: "XBUser")
        query.whereKey("user", equalTo: user.text)
        query.getFirstObjectInBackgroundWithBlock { (user, error) in
            if user != nil {
                self.clearAllNotice()
                self.errorNotice("已使用的用户名")
                self.view.userInteractionEnabled = true
                self.user.becomeFirstResponder()
                self.doneButton.enabled = false
            } else {
                regdata.saveInBackgroundWithBlock({ (_, error) in
                    if error == nil {
                        self.clearAllNotice()
                        self.successNotice("注册成功")
                        afterDelay(1.1, closure: {
                            self.navigationController?.popViewControllerAnimated(true)
                        })
                    } else {
                        print(error)
                    }
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBarHidden = false
        
        //用户名校验
        let v1 = AJWValidator(type: .String)
        v1.addValidationToEnsureRangeWithMinimum(3, maximum: 15, invalidMessage: "用户名应在3-15位之间")
        user.ajw_attachValidator(v1)
        v1.validatorStateChangedHandler = { (newState: AJWValidatorState) -> Void in
            switch newState {
            case .ValidationStateValid:
                self.user.highlightState = UITextBoxHighlightState.Correct("✔️")
                self.userOK = true
            default:
                if let errMsg = v1.errorMessages.first as? String {
                    self.user.highlightState = UITextBoxHighlightState.Wrong(errMsg)
                    self.userOK = false
                }
            }
            self.doneButton.enabled = self.userOK && self.passOK && self.mailOK
        }
        
        
        //密码校验
        let v2 = AJWValidator(type: .String)
        v2.addValidationToEnsureRangeWithMinimum(6, maximum: 15, invalidMessage: "密码应在6-15位之间")
        pass.ajw_attachValidator(v2)
        v2.validatorStateChangedHandler = { (newState: AJWValidatorState) -> Void in
            switch newState {
            case .ValidationStateValid:
                self.pass.highlightState = UITextBoxHighlightState.Correct("✔️")
                self.passOK = true
            default:
                if let errMsg = v2.errorMessages.first as? String {
                    self.pass.highlightState = UITextBoxHighlightState.Wrong(errMsg)
                    self.passOK = false
                }
            }
            self.doneButton.enabled = self.userOK && self.passOK && self.mailOK
        }
        
        //邮箱校验
        let v3 = AJWValidator(type: .String)
        v3.addValidationToEnsureValidEmailWithInvalidMessage("邮箱格式错误！")
        mail.ajw_attachValidator(v3)
        v3.validatorStateChangedHandler = { (newState: AJWValidatorState) -> Void in
            switch newState {
            case .ValidationStateValid:
                self.mail.highlightState = UITextBoxHighlightState.Correct("✔️")
                self.mailOK = true
            default:
                if let errMsg = v3.errorMessages.first as? String {
                    self.mail.highlightState = UITextBoxHighlightState.Wrong(errMsg)
                    self.mailOK = false
                }
            }
            self.doneButton.enabled = self.userOK && self.passOK && self.mailOK
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

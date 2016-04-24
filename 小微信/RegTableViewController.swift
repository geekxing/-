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
    
    @IBAction func done(sender: AnyObject) {
        checkRequired()
    }
    
    func checkRequired() {
        self.view.userInteractionEnabled = false
        self.successNotice("注册成功！")
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

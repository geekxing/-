//
//  ConversationViewController.swift
//  小微信
//
//  Created by 赖霄冰 on 16/4/22.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class ConversationViewController: RCConversationViewController {
    
    deinit {
        print("退出会话界面")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMessageAvatarStyle(.USER_AVATAR_CYCLE)
//        targetId = "laixiaobing2"
//        conversationType = .ConversationType_PRIVATE
//        title = targetId
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

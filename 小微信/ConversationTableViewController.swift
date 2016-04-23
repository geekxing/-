//
//  ConversationTableViewController.swift
//  小微信
//
//  Created by 赖霄冰 on 16/4/22.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class ConversationTableViewController: RCConversationListViewController {
    
    let conVC = ConversationViewController()
    
    @IBAction func showMenu(sender: UIBarButtonItem) {
        var frame = sender.valueForKey("view")?.frame
        frame?.origin.y += 30
        KxMenu.showMenuInView(self.view , fromRect: frame!, menuItems: [
            KxMenuItem.init("客服", image: nil, target: self, action: #selector(didTapMenu1)),
            KxMenuItem.init("好友", image: nil, target: self, action: #selector(didTapMenu2))
            ])
    }
    
    func didTapMenu1() {
        print("进入客服")
    }
    
    func didTapMenu2() {
        conVC.targetId = "laixiaobing"
        conVC.conversationType = RCConversationType.ConversationType_PRIVATE
        conVC.title = "Larry"
        
        self.performSegueWithIdentifier("TaponCell", sender: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        self.refreshConversationTableViewIfNeeded()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        appDelegate?.connectServer() {
            self.setDisplayConversationTypes([
                RCConversationType.ConversationType_APPSERVICE.rawValue,
                RCConversationType.ConversationType_CHATROOM.rawValue,
                RCConversationType.ConversationType_CUSTOMERSERVICE.rawValue,
                RCConversationType.ConversationType_DISCUSSION.rawValue,
                RCConversationType.ConversationType_PRIVATE.rawValue,
                RCConversationType.ConversationType_GROUP.rawValue
                ])
            self.refreshConversationTableViewIfNeeded()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let chatVC = segue.destinationViewController as! RCConversationViewController
        chatVC.targetId = conVC.targetId
        chatVC.conversationType = conVC.conversationType
        chatVC.title = conVC.title
        
        self.tabBarController?.tabBar.hidden = true
    }
    
    // MARK: - RCConVC function
    
    override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {
        
        conVC.targetId = model.targetId
        conVC.conversationType = RCConversationType.ConversationType_PRIVATE
        conVC.title = model.conversationTitle
        
        self.performSegueWithIdentifier("TaponCell", sender: self)
    }

//    // MARK: - Table View Delegate
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }

}

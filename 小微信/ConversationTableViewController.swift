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
    var friendVC = FriendViewController()
    var leftBarButton: UIBarButtonItem!
    var popMenu: PopoverViewController?
    weak var popController: UIPopoverPresentationController?
    
    @IBAction func showMenu(sender: UIBarButtonItem) {
        var frame = sender.valueForKey("view")?.frame
        frame?.origin.y += 30
        if (popController == nil) {
//            KxMenu.showMenuInView(self.view , fromRect: frame!, menuItems: [
//                KxMenuItem.init("客服", image: nil, target: self, action: #selector(didTapMenu1)),
//                KxMenuItem.init("好友", image: nil, target: self, action: #selector(didTapMenu2))
//                ])
            
            let popItem1 = PopViewItem(menu: "朋友圈", image: UIImage(named: "IconHome"))
            let popItem2 = PopViewItem(menu: "好友", image: UIImage(named: "IconProfile"))
            let popItem3 = PopViewItem(menu: "扫一扫", image: nil)
            let pops = [popItem1,popItem2,popItem3]
            let popMenu = PopoverViewController()
            popMenu.popViewItems = pops
            popMenu.modalPresentationStyle = .Popover
            popMenu.preferredContentSize = CGSizeMake(130, CGFloat(pops.count * 36))
            popController = popMenu.popoverPresentationController
            popController?.delegate = self
            popController?.permittedArrowDirections = .Up
            popController?.barButtonItem = navigationItem.rightBarButtonItem
            presentViewController(popMenu, animated: true, completion: nil)
        }
    }
    
    func didTapMenu1() {
        print("进入客服")
    }
    
    func didTapMenu(notification: NSNotification) {
        let indexPath = notification.object as! NSIndexPath
        print("\(indexPath)")
        switch indexPath.row {
        case 0:
            performSegueWithIdentifier("FriendCircle", sender: nil)
        case 1:
            performSegueWithIdentifier("TaponCell", sender: nil)
        default: break
        }
        if popMenu != nil {
            popMenu!.dismissViewControllerAnimated(true) {self.popMenu = nil;self.popController = nil}
        }
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
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "xsx_yjd"), forBarMetrics: .Default)
        let image = UIImage(named: "head1")
        let leftImageItemView = UIImageView(frame: CGRectMake(3, 25, 40, 40))
        leftImageItemView.layer.cornerRadius = CGFloat(20)
        leftImageItemView.layer.masksToBounds = true
        leftImageItemView.image = image
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftImageItemView)
        leftBarButton = navigationItem.leftBarButtonItem
        leftBarButton.action = #selector(transtoSideBar)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didTapMenu), name: "click", object: nil)
    }
    
    func transtoSideBar() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TaponCell" {
            let chatVC = segue.destinationViewController as! RCConversationViewController
            chatVC.targetId = conVC.targetId
            chatVC.conversationType = conVC.conversationType
            chatVC.title = conVC.title
        }
        if segue.identifier == "FriendCircle" {
            friendVC = segue.destinationViewController as! FriendViewController
        }
        
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

extension ConversationTableViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
}

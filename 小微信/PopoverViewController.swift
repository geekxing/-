//
//  PopoverViewController.swift
//  小微信
//
//  Created by 赖霄冰 on 16/4/26.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class PopoverViewController: UITableViewController {
    
    var popViewItems = [PopViewItem]()
    let identifier = "Cell"
    
    deinit {
        print("弹出菜单释放")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: identifier)
        view.backgroundColor = UIColor.clearColor()
        tableView.backgroundColor = UIColor.clearColor()
        tableView.rowHeight = 36
        tableView.scrollEnabled = false
        tableView.separatorColor = UIColor.clearColor()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return popViewItems.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        NSNotificationCenter.defaultCenter().postNotificationName("click", object: indexPath)
    }
    
    // MARK: - Table view delegate
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        cell.contentView.backgroundColor = UIColor(white: 0.3, alpha: 0.9)
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        cell.textLabel?.sizeToFit()
        let selectionView = UIView(frame: CGRect.zero)
        selectionView.backgroundColor = UIColor.darkGrayColor()
        cell.selectedBackgroundView = selectionView
        cell.imageView?.frame.size = CGSizeMake(30, 30)
        let popViewItem = popViewItems[indexPath.row]
        cell.textLabel?.text = popViewItem.menu
        if let image = popViewItem.image {
            cell.imageView?.image = image
        } else {
            cell.imageView?.image = UIImage(named: "IconEmpty")
        }
        
        return cell
    }

}

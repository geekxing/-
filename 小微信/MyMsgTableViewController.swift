//
//  MyMsgTableViewController.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/5.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class MyMsgTableViewController: UITableViewController {
    
    var cellResult = [Int]()

    @IBOutlet weak var clearButton: UIBarButtonItem!
    
    @IBAction func clear(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let delAction = UIAlertAction(title: "清空所有消息", style: .Destructive) { (_) in
            self.cellResult.removeAll()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        alert.addAction(delAction)
        alert.addAction(cancelAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 136
        var nib = UINib(nibName: "MsgCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "MsgCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MsgCell") as! MyMsgTableViewCell
        cell.configureCell()
        return cell
    }

}

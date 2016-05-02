//
//  FriendViewController.swift
//  小微信
//
//  Created by 赖霄冰 on 16/4/27.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class FriendViewController: UITableViewController {

    var jsonResults = [JSONResult]()
    let parseJSON = ParseJSON()
    deinit {
        print("退出朋友圈")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 200
        tableView.fd_debugLogEnabled = true
        var nib = UINib(nibName: "HeadImageCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "HeadImageCell")
        nib = UINib(nibName: "FriendCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "FriendCell")
        let dataPath = NSBundle.mainBundle().pathForResource("data", ofType: "json")
        if let data = NSData(contentsOfFile: dataPath!) {
           jsonResults = parseJSON.loadJSONData(data)
        }
        //tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Data Source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonResults.count
    }

    
//    //MARK: - Delegate
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("HeadImageCell", forIndexPath: indexPath) as! HeadImageTableViewCell
            cell.bigImageView.image = UIImage(named: "image1")
            cell.headImageView.image = UIImage(named: "head1")
            cell.label.text = "赖霄冰"
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath) as! FriendTableViewCell
            let jsonResult = jsonResults[indexPath.row]
            cell.configureCell(jsonResult)
            cell.selectionStyle = .None
            return  cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.fd_heightForCellWithIdentifier("FriendCell", configuration: { (cell) in
            let cell = cell as! FriendTableViewCell
            
            let jsonResult = self.jsonResults[indexPath.row]
            cell.configureCell(jsonResult)
        })
    }
    
}
